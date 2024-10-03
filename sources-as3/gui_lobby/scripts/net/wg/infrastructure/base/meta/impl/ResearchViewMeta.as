package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ResearchViewMeta extends AbstractView
   {
       
      
      public var request4Buy:Function;
      
      public var request4Info:Function;
      
      public var request4Restore:Function;
      
      public var showSystemMessage:Function;
      
      public var goToBlueprintView:Function;
      
      public var goToNationChangeView:Function;
      
      public var goToVehicleCollection:Function;
      
      public var goToEarlyAccessQuestsView:Function;
      
      public var goToEarlyAccessBuyView:Function;
      
      private var _array:Array;
      
      private var _array1:Array;
      
      private var _array2:Array;
      
      private var _array3:Array;
      
      private var _array4:Array;
      
      public function ResearchViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         if(this._array1)
         {
            this._array1.splice(0,this._array1.length);
            this._array1 = null;
         }
         if(this._array2)
         {
            this._array2.splice(0,this._array2.length);
            this._array2 = null;
         }
         if(this._array3)
         {
            this._array3.splice(0,this._array3.length);
            this._array3 = null;
         }
         if(this._array4)
         {
            this._array4.splice(0,this._array4.length);
            this._array4 = null;
         }
         super.onDispose();
      }
      
      public function request4BuyS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.request4Buy,"request4Buy" + Errors.CANT_NULL);
         this.request4Buy(param1);
      }
      
      public function request4InfoS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.request4Info,"request4Info" + Errors.CANT_NULL);
         this.request4Info(param1,param2);
      }
      
      public function request4RestoreS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.request4Restore,"request4Restore" + Errors.CANT_NULL);
         this.request4Restore(param1);
      }
      
      public function showSystemMessageS(param1:String, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.showSystemMessage,"showSystemMessage" + Errors.CANT_NULL);
         this.showSystemMessage(param1,param2);
      }
      
      public function goToBlueprintViewS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.goToBlueprintView,"goToBlueprintView" + Errors.CANT_NULL);
         this.goToBlueprintView(param1);
      }
      
      public function goToNationChangeViewS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.goToNationChangeView,"goToNationChangeView" + Errors.CANT_NULL);
         this.goToNationChangeView(param1);
      }
      
      public function goToVehicleCollectionS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.goToVehicleCollection,"goToVehicleCollection" + Errors.CANT_NULL);
         this.goToVehicleCollection(param1);
      }
      
      public function goToEarlyAccessQuestsViewS() : void
      {
         App.utils.asserter.assertNotNull(this.goToEarlyAccessQuestsView,"goToEarlyAccessQuestsView" + Errors.CANT_NULL);
         this.goToEarlyAccessQuestsView();
      }
      
      public function goToEarlyAccessBuyViewS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.goToEarlyAccessBuyView,"goToEarlyAccessBuyView" + Errors.CANT_NULL);
         this.goToEarlyAccessBuyView(param1);
      }
      
      public final function as_setNodesStates(param1:Number, param2:Array, param3:Boolean) : void
      {
         var _loc4_:Array = this._array;
         this._array = param2;
         this.setNodesStates(param1,this._array,param3);
         if(_loc4_)
         {
            _loc4_.splice(0,_loc4_.length);
         }
      }
      
      public final function as_setNext2Unlock(param1:Array) : void
      {
         var _loc2_:Array = this._array1;
         this._array1 = param1;
         this.setNext2Unlock(this._array1);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setVehicleTypeXP(param1:Array) : void
      {
         var _loc2_:Array = this._array2;
         this._array2 = param1;
         this.setVehicleTypeXP(this._array2);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setInventoryItems(param1:Array) : void
      {
         var _loc2_:Array = this._array3;
         this._array3 = param1;
         this.setInventoryItems(this._array3);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setNodeVehCompareData(param1:Array) : void
      {
         var _loc2_:Array = this._array4;
         this._array4 = param1;
         this.setNodeVehCompareData(this._array4);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setNodesStates(param1:Number, param2:Array, param3:Boolean) : void
      {
         var _loc4_:String = "as_setNodesStates" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc4_);
         throw new AbstractException(_loc4_);
      }
      
      protected function setNext2Unlock(param1:Array) : void
      {
         var _loc2_:String = "as_setNext2Unlock" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setVehicleTypeXP(param1:Array) : void
      {
         var _loc2_:String = "as_setVehicleTypeXP" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setInventoryItems(param1:Array) : void
      {
         var _loc2_:String = "as_setInventoryItems" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setNodeVehCompareData(param1:Array) : void
      {
         var _loc2_:String = "as_setNodeVehCompareData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
