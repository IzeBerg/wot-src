from items.components import c11n_constants

def customizationSlotTagsValidator(tag):
    availableTags = c11n_constants.ProjectionDecalDirectionTags.ALL + c11n_constants.ProjectionDecalFormTags.ALL + c11n_constants.ProjectionDecalPreferredTags.ALL + (
     c11n_constants.HIDDEN_FOR_USER_TAG,)
    if tag in availableTags:
        return True
    return tag.endswith(c11n_constants.MATCHING_TAGS_SUFFIX)