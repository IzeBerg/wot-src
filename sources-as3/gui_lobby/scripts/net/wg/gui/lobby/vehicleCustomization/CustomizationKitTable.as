package net.wg.gui.lobby.vehicleCustomization
{
   import flash.events.Event;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class CustomizationKitTable extends CoreList
   {
       
      
      public function CustomizationKitTable()
      {
         super();
      }
      
      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint
      {
         if(_dataProvider)
         {
            return _dataProvider.length;
         }
         return super.calculateRendererTotal(param1,param2);
      }
      
      override protected function refreshData() : void
      {
         var _loc1_:uint = 0;
         if(_renderers && _dataProvider)
         {
            _loc1_ = Math.min(_renderers.length,_dataProvider.length);
         }
         _dataProvider.requestItemRange(0,_loc1_,this.populateData);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(!_usingExternalRenderers && isInvalid(InvalidationType.RENDERERS,InvalidationType.SIZE))
         {
            this.layoutRenderers();
         }
      }
      
      protected function populateData(param1:Array) : void
      {
         var _loc5_:IListItemRenderer = null;
         var _loc2_:uint = param1.length;
         var _loc3_:uint = _renderers.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = getRendererAt(_loc4_);
            _loc5_.enabled = _loc4_ >= _loc2_ ? Boolean(false) : Boolean(true);
            _loc5_.setData(param1[_loc4_]);
            _loc5_.validateNow();
            _loc4_++;
         }
      }
      
      protected function layoutRenderers() : void
      {
         var _loc5_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_)
         {
            _loc5_ = getRendererAt(_loc4_);
            _loc5_.y = _loc3_;
            if(!_loc2_)
            {
               _loc5_.validateNow();
            }
            _loc3_ += _loc5_.height;
            _loc4_++;
         }
         dispatchEvent(new Event(Event.RESIZE,true));
      }
   }
}
