package net.wg.gui.lobby.hangar.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HeaderQuestGroupVO extends DAAPIDataClass
   {
      
      private static const QUEST_FIELD_NAME:String = "quests";
       
      
      public var groupID:String = "";
      
      public var groupIcon:String = "";
      
      public var isRightSide:Boolean = false;
      
      private var _quests:Vector.<HeaderQuestsVO> = null;
      
      public function HeaderQuestGroupVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == QUEST_FIELD_NAME)
         {
            this._quests = Vector.<HeaderQuestsVO>(App.utils.data.convertVOArrayToVector(param1,param2,HeaderQuestsVO));
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._quests != null)
         {
            for each(_loc1_ in this._quests)
            {
               _loc1_.dispose();
            }
            this._quests.splice(0,this._quests.length);
            this._quests = null;
         }
         super.onDispose();
      }
      
      public function get getQuests() : Vector.<HeaderQuestsVO>
      {
         return this._quests;
      }
   }
}
