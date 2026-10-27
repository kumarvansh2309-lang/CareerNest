require('dotenv').config();
const fs = require('fs'); const path = require('path'); const { Pool } = require('pg');
async function main() {
 if (!process.env.DATABASE_URL) { console.error('Set DATABASE_URL in .env first.'); process.exit(1); }
 const pool = new Pool({ connectionString: process.env.DATABASE_URL,
   ssl: process.env.DATABASE_URL.includes('localhost') ? false : { rejectUnauthorized:false } });
 try {
  await pool.query(fs.readFileSync(path.join(__dirname,'schema.sql'),'utf8'));
  const count = await pool.query('SELECT COUNT(*)::int AS count FROM jobs');
  if (count.rows[0].count === 0) await pool.query(`INSERT INTO jobs(title,company,location,job_type,salary,description,requirements) VALUES
  ('Frontend Developer','PixelCraft','Remote','Full-time','₹5–8 LPA','Build accessible, responsive interfaces with designers.','HTML, CSS, JavaScript, React basics'),
  ('Junior Backend Developer','Northstar Labs','Noida, India','Full-time','₹4–7 LPA','Build REST APIs and maintain backend services.','JavaScript, Node.js, SQL fundamentals'),
  ('UI/UX Design Intern','BrightPath Studio','Delhi NCR','Internship','₹12,000/month','Support user research, wireframes and prototypes.','Figma, interaction design'),
  ('Full Stack Developer Intern','LaunchGrid','Remote','Internship','₹15,000/month','Work across frontend components and API integrations.','JavaScript, React, API basics')`);
  console.log('Schema ready; sample jobs inserted if database was empty.');
 } finally { await pool.end(); }
}
main().catch(e=>{console.error(e);process.exit(1);});
