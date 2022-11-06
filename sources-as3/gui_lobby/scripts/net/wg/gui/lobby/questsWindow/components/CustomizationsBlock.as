package net.wg.gui.lobby.questsWindow.components
{
   import flash.events.Event;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class CustomizationsBlock extends AbstractResizableContent
   {
      
      private static const RENDERERS_GAP_X:int = 2;
      
      private static const RENDERERS_GAP_Y:int = 5;
      
      private static const INSCRIPTION_IR_LINKAGE:String = "InscriptionItemRenderer_UI";
      
      private static const CUSTOMIZATION_IR_LINKAGE:String = "CustomizationItemRendererUI";
       
      
      private var _data:Object;
      
      private var _renderers:Array;
      
      public function CustomizationsBlock()
      {
         this._renderers = [];
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 && this._data != param1)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.destroyRenderers();
            if(this._data)
            {
               this.createRenderers();
               invalidateSize();
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.layoutRenderers();
         }
      }
      
      override protected function onDispose() : void
      {
         this.destroyRenderers();
         this._renderers = null;
         this._data = null;
         super.onDispose();
      }
      
      private function destroyRenderers() : void
      {
         var _loc1_:CustomizationItemRenderer = null;
         for each(_loc1_ in this._renderers)
         {
            removeChild(_loc1_);
            _loc1_.removeEventListener(Event.RESIZE,this.onItemRendererResizeHandler);
            _loc1_.dispose();
         }
         this._renderers.splice(0);
      }
      
      private function createRenderers() : void
      {
         var _loc1_:Object = null;
         var _loc2_:UIComponent = null;
         var _loc3_:String = null;
         for each(_loc1_ in this._data.list)
         {
            _loc3_ = _loc1_.type == 2 ? INSCRIPTION_IR_LINKAGE : CUSTOMIZATION_IR_LINKAGE;
            _loc2_ = App.utils.classFactory.getComponent(_loc3_,CustomizationItemRenderer,{"data":_loc1_});
            _loc2_.addEventListener(Event.RESIZE,this.onItemRendererResizeHandler);
            _loc2_.validateNow();
            addChild(_loc2_);
            this._renderers.push(_loc2_);
         }
      }
      
      private function layoutRenderers() : void
      {
         var _loc2_:int = 0;
         var _loc3_:CustomizationItemRenderer = null;
         var _loc1_:int = 0;
         _loc2_ = 0;
         for each(_loc3_ in this._renderers)
         {
            if(_loc1_ + RENDERERS_GAP_X + _loc3_.actualWidth > width)
            {
               _loc1_ = 0;
               _loc2_ += RENDERERS_GAP_Y + _loc3_.height;
            }
            _loc3_.x = _loc1_;
            _loc3_.y = _loc2_;
            _loc1_ += RENDERERS_GAP_X + _loc3_.actualWidth;
         }
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      override public function get height() : Number
      {
         var _loc2_:UIComponentEx = null;
         var _loc1_:int = this._renderers.length - 1;
         if(_loc1_ > -1)
         {
            _loc2_ = this._renderers[_loc1_];
            return _loc2_.y + _loc2_.height + RENDERERS_GAP_X;
         }
         return super.height;
      }
      
      private function onItemRendererResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
