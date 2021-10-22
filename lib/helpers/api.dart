enum BookmarkAction {
  add,
  delete,
}

class GraphQlQuery {
  static String getJob(String id) {
    return """
    query job {
    get_jobs(_id: "${id}"){
      _id
      _created_at
      job_name
      start_date
      end_date
      company  {
        name
        about
      }
      is_saved
      education_requirement{
        category
        level
        name
      }
      spoken_skill{
        name
        level
      }
      written_skill{
        name
        level
      }
      attributes {
        category
        category_display_sequence
      }
      allowances {
        name
        description
      }
      job_types {
        category
        name
        __typename
      }
      to_monthly_rate
      to_hourly_rate

      employment
      employment_type {
        name
      }
      state
      attributes {
        category
      }
      address {
        address 
        formatted_address
      }
      address_on_map
      images
    is_applied
    is_invited
  }
}
  """;
  }

  static String getAllJobs(int limit) {
    return """
    query job {
      job_search (limit: $limit){
        total
        result{
          _id
          _created_at
          job_name
          company {
            name
            about
          }
          attributes {
            category
            category_display_sequence
          }
          allowances {
            name
            description
          }
          job_types {
            category
            name
            __typename
          }
          education_requirement{
            category
            level
            name
          }
          to_monthly_rate
          to_hourly_rate
    
          employment
          employment_type {
            name
          }
         spoken_skill{
            name
            level
          }
          written_skill{
            name
            level
          }
          state
          attributes {
            category
          }
          address{
            address
            formatted_address
          }
          address_on_map
          images
        }
      }
    }
  """;
  }

  static String updateBookmark(String action, String jobId) {
    return """
          mutation update_bookmark(
            \$action: BookmarkAction!, 
            \$job_id: ID!) {
                  update_bookmark (
                    action: \$action
                    job_id: \$job_id
                  ) {
                    total
                    bookmarks {
                      _created_at
                    }
                  }
                }
    """;
  }

  static String getBookmarks(int limit) {
    return """
      query SavedJob{
        saved_jobs(limit:$limit) {
          total
          bookmarks {
            _created_at
            job {
              _id
              _created_at
              job_name
              start_date
              end_date
              address{
                address
                formatted_address
              }
              company  {
                name
                about
              }
              job_types {
                category
                name
                __typename
              }
              to_monthly_rate
              to_hourly_rate
        
              employment
              employment_type {
                name
              }
            }
          }
          
        }
      }
    """;
  }
}
