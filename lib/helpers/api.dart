class GraphQlQuery{
  static String getJob() {
    return """
    query job(\$ids: [ID]) {
    get_jobs(_id: \$ids){
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
      to_working_days_per_week
      to_working_hours_per_day
      vacancy
      working_hour{
        _id
        day_of_week
        end_time
        shift_name
        start_time
        }
      }
    }
    """;
  }

  static String getAllJobs() {
    return """
    query job (\$limit: Int){
      job_search (limit: \$limit){
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
          to_working_days_per_week
          to_working_hours_per_day
          vacancy
          working_hour{
            _id
            day_of_week
            end_time
            shift_name
            start_time
          }
        }
      }
    }
  """;

  }

  static String updateBookmark() {
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

  static String getBookmarks() {
    return """
      query SavedJob(\$limit){
        saved_jobs(limit:\$limit) {
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

  static String SearchWithParams() {
    return """
      query SearchWithParams(\$limit: Int, \$monthly_rate: [Float], \$term: String) {
        job_search(limit: \$limit, monthly_rate: \$monthly_rate, term: \$term) {
          total
          result {
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
            education_requirement {
              category
              level
              name
            }
            job_types {
              _id
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
          }
        }
      }
    """;
  }
}