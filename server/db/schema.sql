CREATE TABLE IF NOT EXISTS users (
 id SERIAL PRIMARY KEY, name VARCHAR(120) NOT NULL, email VARCHAR(255) UNIQUE NOT NULL,
 password_hash TEXT NOT NULL, role VARCHAR(20) NOT NULL DEFAULT 'seeker'
 CHECK (role IN ('seeker','recruiter')),
 profile_title VARCHAR(180), skills TEXT, education TEXT, bio TEXT, resume_filename TEXT, resume_data TEXT,
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS jobs (
 id SERIAL PRIMARY KEY, title VARCHAR(180) NOT NULL, company VARCHAR(180) NOT NULL,
 location VARCHAR(180) NOT NULL, job_type VARCHAR(40) NOT NULL DEFAULT 'Full-time',
 salary VARCHAR(100), description TEXT NOT NULL, requirements TEXT,
 posted_by INTEGER REFERENCES users(id) ON DELETE SET NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS applications (
 id SERIAL PRIMARY KEY, job_id INTEGER NOT NULL REFERENCES jobs(id) ON DELETE CASCADE,
 user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE, cover_letter TEXT,
 status VARCHAR(30) NOT NULL DEFAULT 'Submitted'
 CHECK (status IN ('Submitted','Reviewing','Interview','Rejected','Accepted')),
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), UNIQUE(job_id,user_id)
);

-- Safe upgrades for databases created from earlier versions of CareerNest.
ALTER TABLE users ADD COLUMN IF NOT EXISTS profile_title VARCHAR(180);
ALTER TABLE users ADD COLUMN IF NOT EXISTS skills TEXT;
ALTER TABLE users ADD COLUMN IF NOT EXISTS education TEXT;
ALTER TABLE users ADD COLUMN IF NOT EXISTS bio TEXT;
ALTER TABLE users ADD COLUMN IF NOT EXISTS resume_filename TEXT;
ALTER TABLE users ADD COLUMN IF NOT EXISTS resume_data TEXT;
