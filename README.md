# CareerNest — Full-Stack Job Portal

A full-stack internship project using **Next.js, Express.js and PostgreSQL**.

## Features
- Search and filter job listings by keyword, location and employment type
- Seeker and recruiter accounts, password hashing with bcrypt and JWT authentication
- Recruiters can publish job listings
- Job seekers can apply with a cover letter and track application status
- **Profile builder:** professional headline, skills, education and bio
- **Resume upload:** PDF, DOC or DOCX, maximum 5 MB (stored in PostgreSQL; use private storage in production)
- **Job recommendations:** profile-keyword matching with a visible demo match score (rule-based/AI-style demo, not a third-party AI model)
- Responsive interface and seeded example jobs

## Requirements
- Node.js 20+
- PostgreSQL database

## Run locally or in a Node-capable online IDE
1. Create a PostgreSQL database named `careernest`.
2. Copy `.env.example` to `.env` and set `DATABASE_URL` plus a strong, private `JWT_SECRET`.
3. Install packages: `npm install`
4. Create/update tables and seed example jobs: `npm run db:setup`
5. Start frontend and backend: `npm run dev`
6. Open the Next.js URL printed in the terminal. The API runs on port 4000 by default.

Set `NEXT_PUBLIC_API_URL` to the reachable Express API URL if the frontend and backend are hosted separately. Never publish `.env` or secrets to GitHub.

## Main API routes
- `GET /api/health`
- `GET /api/jobs?search=&location=&type=`
- `POST /api/auth/register`, `POST /api/auth/login`
- `POST /api/jobs` (recruiter token required)
- `POST /api/jobs/:id/apply` (seeker token required)
- `GET /api/applications/me` (login required)
- `GET /api/profile/me`, `PUT /api/profile/me` (login required)
- `PUT /api/profile/resume` (seeker token required; JSON base64 file payload)
- `GET /api/recommendations` (seeker token required)

## Important notes
This is an educational project and has **not been deployed or end-to-end tested in a configured PostgreSQL environment**. Resume storage in the database is suitable only for a small demo; production should use private object storage, file scanning, stricter upload validation, rate limiting, email verification, and more comprehensive authorization and tests. Recommendations are rule-based keyword matching to demonstrate the feature, not a generative AI integration.
