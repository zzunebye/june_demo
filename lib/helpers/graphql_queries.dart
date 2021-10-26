class GraphQlFragment {
  static final jobsTypesFields = '''
    fragment jobTypesFields on JobType {
      category
      name
    }
  ''';

  static final jobsWorkingHourFields = '''
    fragment jobsWorkingHourFields on WorkingHour {
      _id
      day_of_week
      end_time
      shift_name
      start_time
    }
  ''';

  static final jobFields = '''
    ${GraphQlFragment.jobsWorkingHourFields}
    
    fragment jobFields on Job {
        job_name
        _created_at
        _id
        company {
          name
          about
        }
        is_saved
        attributes {
          category
          category_display_sequence
        }
        allowances {
          name
          description
        }
        job_types{
          category
          name
        }
        to_monthly_rate
        to_hourly_rate
        education_requirement{
          category
          level
          name
        }
        employment
        employment_type {
          name
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
          ...jobsWorkingHourFields
        }
        spoken_skill {
          level
          name
        }
        written_skill {
          level
          name
        }
    }
  ''';

  static final jobCardFields = '''
    ${GraphQlFragment.jobsWorkingHourFields}

    fragment jobFields on Job {
        job_name
        _created_at
        _id
        company {
          name
          about
        }
        is_saved
        attributes {
          category
          category_display_sequence
        }
        allowances {
          name
          description
        }
        job_types{
          category
          name
        }
        employment
        to_monthly_rate
        to_hourly_rate
        employment_type {
          name
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
        start_date
        end_date    
        to_working_days_per_week
        to_working_hours_per_day
        vacancy
        working_hour{
         ...jobsWorkingHourFields
        }
    }
  ''';
}

class GraphQlQuery {
  static String getJob() {
    return """
    ${GraphQlFragment.jobFields}
    
    query job(\$ids: [ID]) {
      get_jobs(_id: \$ids){
      ...jobFields
      }
    }
    """;
  }

  static String getAllJobs() {
    return """
    ${GraphQlFragment.jobFields}

    query job (\$limit: Int){
      job_search (limit: \$limit){
        total
        result{
          ...jobFields
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

      query SavedJob(\$limit: Int){
        saved_jobs(limit:\$limit) {
          total
          bookmarks {
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
      ${GraphQlFragment.jobFields}

      query SearchWithParams(\$limit: Int, \$monthly_rate: [Float], \$term: String) {
        job_search(limit: \$limit, monthly_rate: \$monthly_rate, term: \$term) {
          total
          result {
            ...jobFields
          }
        }
      }
    """;
  }
}
