package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class TutorialQuestDescVO extends DAAPIDataClass
   {
      
      private static const COND_ITEMS_FIELD_NAME:String = "conditionItems";
       
      
      public var conditionsTitle:String = "";
      
      public var descTitle:String = "";
      
      public var descText:String = "";
      
      private var _conditionItems:DataProvider = null;
      
      public function TutorialQuestDescVO(param1:Object)
      {
         this._conditionItems = new DataProvider();
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         if(param1 == COND_ITEMS_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this._conditionItems.push(new TutorialQuestConditionRendererVO(_loc3_[_loc5_]));
               _loc5_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._conditionItems)
         {
            _loc1_.dispose();
         }
         this._conditionItems.cleanUp();
         this._conditionItems = null;
         super.onDispose();
      }
      
      public function get conditionItems() : DataProvider
      {
         return this._conditionItems;
      }
   }
}
