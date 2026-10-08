FROM node:22-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

ARG VITE_USER_SERVICE_URL=/api/users
ARG VITE_STUDENT_SERVICE_URL=/api/students
ARG VITE_LECTURER_SERVICE_URL=/api/lecturers
ARG VITE_COURSE_SERVICE_URL=/api/courses
ARG VITE_ENROLLMENT_SERVICE_URL=/api/enrollments

ENV VITE_USER_SERVICE_URL=${VITE_USER_SERVICE_URL}
ENV VITE_STUDENT_SERVICE_URL=${VITE_STUDENT_SERVICE_URL}
ENV VITE_LECTURER_SERVICE_URL=${VITE_LECTURER_SERVICE_URL}
ENV VITE_COURSE_SERVICE_URL=${VITE_COURSE_SERVICE_URL}
ENV VITE_ENROLLMENT_SERVICE_URL=${VITE_ENROLLMENT_SERVICE_URL}

RUN npm run build

# Current stable nginx on Alpine, with every OS package upgraded so the
# image does not ship critical CVEs that already have a fix.
FROM nginx:stable-alpine

RUN apk upgrade --no-cache

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
