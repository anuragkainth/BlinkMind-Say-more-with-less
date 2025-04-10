﻿# BlinkMind - Say more with less


BlinkMind is designed as a full-stack Ruby on Rails application that demonstrates core functionalities of a social networking platform. The app enables users to create accounts, share posts (or “thoughts”), view a home feed featuring posts from themselves and their friends, send and accept friend requests, and like posts. The user interface is designed to be attractive, intuitive, responsive, and minimalist using Simple.css.

## Features

### User Authentication:

- Sign up with email, password, name, about, and optional profile picture upload.
- Log in and log out.
- Forgot password functionality with password reset email (using Letter Opener Web in development).

### Home Feed:

- View a feed of posts from the logged-in user and their accepted friends.
- Create new posts (limited to 280 characters).

### User Profiles:

- View your own profile or that of friends.
- Edit your profile details (including profile picture via file upload).
- Dynamic display of posts and friend count.

### Friendship System:

- Send friend requests.
- Accept or reject pending friend requests.
- View a list of accepted friends.
- Search for members by name or email and send friend requests.

### Post Interaction:

- Like and unlike posts.
- View the number of likes on each post.

## Tech Stack
- **Backend:** Ruby on Rails 8.0.1
- **Frontend:** Embedded Rails views styled with Simple.css
- **Database:** SQLite3 (default Rails setup)

## Installation & Setup

### Prerequisites

- Ruby (3.3.7 or compatible version)
- Rails (8.0.1 or higher)
- Bundler
- Git

### Clone the Repository

Open your terminal and run:

```bash
https://github.com/anuragkainth/BlinkMind-Say-more-with-less.git
```

### Install Dependencies

Run the following command to install all required gems:

```bash
bundle install
```

### Database Setup

Set up your database by running:

```bash
rails db:create
rails db:migrate
```
### Active Storage Setup

Active Storage is already installed via Rails migrations. If needed, you can install it with:

```bash
rails active_storage:install
rails db:migrate
```
## Usage

Running the Application

Start your Rails server with:

```bash
rails s
```
Then, open your browser and navigate to:
http://localhost:3000

## Application Workflow

1. Authentication:

  - Create a new account via the signup page.
  -Log in with your credentials.

2. Home Feed & Posts:

  - Once logged in, you will be redirected to the home feed where you can view posts from yourself and accepted friends.
  - Create new posts by clicking "Share a Thought."

3. Friend Management:

  - Visit the Friends section to view your current friends, pending friend requests, or search for new friends.
  - Send, accept, or reject friend requests.

4. Profile & Account:

  - Visit your account page to view or edit your profile details.
  - Update your profile picture using the file upload field.
