package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.data.MetaLevelVO;
   import net.wg.gui.lobby.hangar.data.AlertMessageBlockVO;
   import net.wg.gui.lobby.hangar.data.HeaderQuestGroupVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EpicBattlesWidgetVO extends DAAPIDataClass
   {
      
      private static const CALENDAR_STATUS_LBL:String = "calendarStatus";
      
      private static const EPIC_META_LEVEL_ICON_VO:String = "epicMetaLevelIconData";
      
      private static const QUESTS_FIELD:String = "quests";
       
      
      public var calendarStatus:AlertMessageBlockVO = null;
      
      public var epicMetaLevelIconData:MetaLevelVO = null;
      
      public var showAlert:Boolean = false;
      
      public var eventMode:String = "front_line_mode";
      
      private var _questsGroups:Vector.<HeaderQuestGroupVO> = null;
      
      public function EpicBattlesWidgetVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.calendarStatus != null)
         {
            this.calendarStatus.dispose();
            this.calendarStatus = null;
         }
         if(this.epicMetaLevelIconData != null)
         {
            this.epicMetaLevelIconData.dispose();
            this.epicMetaLevelIconData = null;
         }
         if(this._questsGroups != null)
         {
            for each(_loc1_ in this._questsGroups)
            {
               _loc1_.dispose();
            }
            this._questsGroups.splice(0,this._questsGroups.length);
            this._questsGroups = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:HeaderQuestGroupVO = null;
         var _loc6_:int = 0;
         if(param1 == CALENDAR_STATUS_LBL)
         {
            this.calendarStatus = new AlertMessageBlockVO(param2);
            return false;
         }
         if(param1 == EPIC_META_LEVEL_ICON_VO)
         {
            this.epicMetaLevelIconData = new MetaLevelVO(param2);
            return false;
         }
         if(param1 == QUESTS_FIELD)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,QUESTS_FIELD + Errors.CANT_NULL);
            _loc4_ = _loc3_.length;
            this._questsGroups = new Vector.<HeaderQuestGroupVO>();
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc5_ = new HeaderQuestGroupVO(_loc3_[_loc6_]);
               this._questsGroups.push(_loc5_);
               _loc6_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get questsGroups() : Vector.<HeaderQuestGroupVO>
      {
         return this._questsGroups;
      }
   }
}
