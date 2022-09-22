package net.wg.gui.lobby.quests.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class QuestSlotsDataVO extends DAAPIDataClass
   {
      
      private static const QUEST_SLOTS:String = "questSlots";
       
      
      public var noActiveQuestsText:String = "";
      
      public var hasActiveQuests:Boolean = false;
      
      private var _questSlots:Vector.<QuestSlotVO> = null;
      
      public function QuestSlotsDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(QUEST_SLOTS == param1)
         {
            this._questSlots = new Vector.<QuestSlotVO>(0);
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,QUEST_SLOTS + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_)
            {
               this._questSlots.push(new QuestSlotVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:uint = this._questSlots.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._questSlots[_loc2_].dispose();
            _loc2_++;
         }
         this._questSlots.splice(0,_loc1_);
         this._questSlots = null;
         super.onDispose();
      }
      
      public function get questSlots() : Vector.<QuestSlotVO>
      {
         return this._questSlots;
      }
   }
}
