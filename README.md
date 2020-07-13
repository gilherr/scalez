# Scalez

Scalez home assignment. Part of a fullstack interview.

## Usage

## API

### Scalez

|path|type|notes|
|---|---|---|
| `/users` | PUT | Create a new user |
| `/users` | GET | List all users |
| `/users/{user_id}` | GET | List user history |
| `/funnel/rate?{product_id}&{rating}` | PUT | Put user rating for a product |
| `/funnel/finished` | GET | Update user 'isNew' state  |
| `/closet` | GET | List user liked products |

### Abtest

|path|type|notes|
|---|---|---|
| `/start/{experiment_name}` | GET | Get test allocation for current user |
| `/end/{experiment_name}` | GET | End experiment successfuly |
| `/experiment` | GET | List all experiments |
| `/experiment/{experiment_name}` | GET | List experiment data |

## Data Model

### User

|key|type|
|---|---|
| `user_id` | int |
| `isNew` | bool |
| `created_at` | timestamp |

### Product

|key|type|
|---|---|
| `product_id` | int |
| `meta` | jsonb |

### Rating

|key|type|
|---|---|
| `rating_id` | int |
| `product_id` | int |
| `user_id` | int |
| `like` | bool |
| `created_at` | timestamp |

### ABTest

|key|type|
|---|---|
| `abtest_id` | int |
| `name` | varchar |
| `user_id` | int |
| `group` | bool |
| `conversion` | bool |
| `created_at` | timestamp |
