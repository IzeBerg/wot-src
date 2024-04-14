package net.wg.gui.lobby.hangar.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HangarHeaderVO extends DAAPIDataClass
   {
      
      private static const QUESTS_FIELD:String = "quests";
       
      
      public var isVisible:Boolean = false;
      
      private var _questsGroups:Vector.<HeaderQuestGroupVO> = null;
      
      public function HangarHeaderVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:HeaderQuestGroupVO = null;
         var _loc6_:int = 0;
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
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
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
      
      public function get questsGroups() : Vector.<HeaderQuestGroupVO>
      {
         return this._questsGroups;
      }
   }
}
