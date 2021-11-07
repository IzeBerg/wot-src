package net.wg.gui.components.questProgress
{
   import flash.filters.ColorMatrixFilter;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   
   public class QuestProgressConstsBase
   {
      
      private static var _lockedFilter:ColorMatrixFilter = new ColorMatrixFilter([0.5,0.5,0.5,0,0,0.5,0.5,0.5,0,0,0.5,0.5,0.5,0,0,1,1,1,1,1]);
       
      
      public function QuestProgressConstsBase()
      {
         super();
      }
      
      public static function getHeaderItemLinkage(param1:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.HEADER_PROGRESS_TYPE_NONE:
               return QUEST_PROGRESS_BASE.HEADER_PROGRESS_LINKAGE_NONE;
            case QUEST_PROGRESS_BASE.HEADER_PROGRESS_TYPE_COUNTER:
               return QUEST_PROGRESS_BASE.HEADER_PROGRESS_LINKAGE_COUNTER;
            case QUEST_PROGRESS_BASE.HEADER_PROGRESS_TYPE_BIATHLON:
               return QUEST_PROGRESS_BASE.HEADER_PROGRESS_LINKAGE_BIATHLON;
            case QUEST_PROGRESS_BASE.HEADER_PROGRESS_TYPE_SERIES:
               return QUEST_PROGRESS_BASE.HEADER_PROGRESS_LINKAGE_SERIES;
            case QUEST_PROGRESS_BASE.HEADER_PROGRESS_TYPE_LIMITED:
               return QUEST_PROGRESS_BASE.HEADER_PROGRESS_LINKAGE_LIMITED;
            case QUEST_PROGRESS_BASE.HEADER_PROGRESS_TYPE_SIMPLE:
               return QUEST_PROGRESS_BASE.HEADER_PROGRESS_LINKAGE_SIMPLE;
            default:
               App.utils.asserter.assert(false,"Header progress for progressType:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      public static function getHeaderBigItemLinkage(param1:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.HEADER_PROGRESS_TYPE_COUNTER:
               return QUEST_PROGRESS_BASE.HEADER_PROGRESS_LINKAGE_BIG_COUNTER;
            case QUEST_PROGRESS_BASE.HEADER_PROGRESS_TYPE_BIATHLON:
               return QUEST_PROGRESS_BASE.HEADER_PROGRESS_LINKAGE_BIG_BIATHLON;
            case QUEST_PROGRESS_BASE.HEADER_PROGRESS_TYPE_SERIES:
               return QUEST_PROGRESS_BASE.HEADER_PROGRESS_LINKAGE_BIG_SERIES;
            default:
               App.utils.asserter.assert(false,"Big header progress for progressType:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      public static function getChartProgress(param1:String, param2:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.VIEW_TYPE_TOP:
               return getChartProgressTopLinkage(param2);
            case QUEST_PROGRESS_BASE.VIEW_TYPE_TAB:
               return getChartProgressTabLinkage(param2);
            case QUEST_PROGRESS_BASE.VIEW_TYPE_QUEST_AWARD:
               return getChartProgressQuestAwardLinkage(param2);
            default:
               App.utils.asserter.assert(false,"Chart progress for viewType:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      public static function getMetricsLinkage(param1:String, param2:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.VIEW_TYPE_TOP:
               return getMetricsTopViewLinkage(param2);
            case QUEST_PROGRESS_BASE.VIEW_TYPE_TAB:
               return getMetricsTabViewLinkage(param2);
            default:
               App.utils.asserter.assert(false,"Metrics for view type:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      public static function getChartIcon(param1:String, param2:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.VIEW_TYPE_TOP:
            case QUEST_PROGRESS_BASE.VIEW_TYPE_TAB:
               return RES_ICONS.maps_icons_quests_battlecondition_90_icon_battle_condition_all_90x90_png(param2);
            case QUEST_PROGRESS_BASE.VIEW_TYPE_QUEST_AWARD:
               return RES_ICONS.maps_icons_quests_battlecondition_128_decor_icon_battle_condition_all_128x128_png(param2);
            default:
               App.utils.asserter.assert(false,"Chart icon \'" + param2 + "\' for view type:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      private static function getChartProgressTopLinkage(param1:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_TYPE_REGULARE:
               return QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_RADIAL_42;
            case QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_TYPE_CUMULATIVE:
               return QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_HEXAGON_40;
            default:
               App.utils.asserter.assert(false,"Chart progress [TOP] for progressType:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      private static function getChartProgressTabLinkage(param1:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_TYPE_REGULARE:
               return QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_RADIAL_54;
            case QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_TYPE_CUMULATIVE:
               return QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_HEXAGON_94;
            default:
               App.utils.asserter.assert(false,"Chart progress [TAB] for progressType:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      private static function getChartProgressQuestAwardLinkage(param1:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_TYPE_REGULARE:
               return QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_RADIAL_100;
            case QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_TYPE_CUMULATIVE:
               return QUEST_PROGRESS_BASE.QUEST_PROGRESS_BAR_HEXAGON_100;
            default:
               App.utils.asserter.assert(false,"Chart progress [PANEL] for progressType:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      private static function getMetricsTopViewLinkage(param1:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_SIMPLE:
               return QUEST_PROGRESS_BASE.QP_METRIC_SIMPLE_CMP_TOP;
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_SIMPLE_VALUE:
               return QUEST_PROGRESS_BASE.QP_METRIC_SIMPLE_VALUE_CMP_TOP;
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_RANGE:
               return QUEST_PROGRESS_BASE.QP_METRIC_RANGE_VALUES_CMP_TOP;
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_VEHICLES:
               return QUEST_PROGRESS_BASE.QP_METRIC_VEHICLES_CMP_TOP;
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_TIMER:
               return QUEST_PROGRESS_BASE.QP_METRIC_TIMER_CMP_TOP;
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_LIMITER:
               return QUEST_PROGRESS_BASE.QP_METRIC_LIMITER_CMP_TOP;
            default:
               App.utils.asserter.assert(false,"Metrics linkage for type:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      private static function getMetricsTabViewLinkage(param1:String) : String
      {
         switch(param1)
         {
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_SIMPLE:
               return QUEST_PROGRESS_BASE.QP_METRIC_SIMPLE_CMP_TAB;
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_SIMPLE_VALUE:
               return QUEST_PROGRESS_BASE.QP_METRIC_SIMPLE_VALUE_CMP_TAB;
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_RANGE:
               return QUEST_PROGRESS_BASE.QP_METRIC_RANGE_VALUES_CMP_TAB;
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_VEHICLES:
               return QUEST_PROGRESS_BASE.QP_METRIC_VEHICLES_CMP_TAB;
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_TIMER:
               return QUEST_PROGRESS_BASE.QP_METRIC_TIMER_CMP_TAB;
            case QUEST_PROGRESS_BASE.QP_METRIC_TYPE_LIMITER:
               return QUEST_PROGRESS_BASE.QP_METRIC_LIMITER_CMP_TAB;
            default:
               App.utils.asserter.assert(false,"Metrics linkage for type:" + param1 + Errors.WASNT_FOUND);
               return null;
         }
      }
      
      public static function get lockedFilter() : ColorMatrixFilter
      {
         return _lockedFilter;
      }
   }
}
