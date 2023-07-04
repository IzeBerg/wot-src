package net.wg.gui.lobby.components
{
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class DataViewStack extends ViewStack
   {
       
      
      protected var _dataForUpdate:Object = null;
      
      public function DataViewStack()
      {
         super();
      }
      
      override public function show(param1:String, param2:String) : IViewStackContent
      {
         var _loc3_:IViewStackContent = super.show(param1,param2);
         this.applyDataToViewObject(_loc3_,this._dataForUpdate);
         return _loc3_;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._dataForUpdate && isInvalid(InvalidationType.DATA))
         {
            this.applyData();
         }
      }
      
      override protected function onDispose() : void
      {
         this._dataForUpdate = null;
         super.onDispose();
      }
      
      public function updateData(param1:Object) : void
      {
         this._dataForUpdate = param1;
         invalidateData();
      }
      
      protected function applyData() : void
      {
         var _loc1_:IUpdatable = null;
         for each(_loc1_ in cachedViews)
         {
            this.applyDataToViewObject(_loc1_,this._dataForUpdate);
         }
      }
      
      protected function applyDataToViewObject(param1:IUpdatable, param2:Object) : void
      {
         param1.update(param2);
      }
   }
}
