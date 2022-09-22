package net.wg.gui.lobby.vehicleTradeWnds.sell
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.VO.SellDialogElementVO;
   import net.wg.data.VO.SellDialogItem;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.events.VehicleSellDialogEvent;
   import net.wg.gui.interfaces.ISaleItemBlockRenderer;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class SellDialogListItemRenderer extends ListItemRenderer
   {
       
      
      public var header:TextField;
      
      public var container:Sprite;
      
      public var rendererBG:MovieClip;
      
      public var scrollingRenderrBg:MovieClip;
      
      private var _elements:Vector.<SellDialogElementVO>;
      
      private var _renderers:Vector.<ISaleItemBlockRenderer>;
      
      public function SellDialogListItemRenderer()
      {
         this._elements = new Vector.<SellDialogElementVO>();
         this._renderers = new Vector.<ISaleItemBlockRenderer>();
         preventAutosizing = true;
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1)
         {
            this.header.text = SellDialogItem(param1).header;
            this._elements = SellDialogItem(param1).elements;
            super.setData(param1);
            invalidateData();
         }
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         var _loc3_:ISaleItemBlockRenderer = null;
         this.scrollingRenderrBg.width = param1;
         for each(_loc3_ in this._renderers)
         {
            _loc3_.setSize(param1,_loc3_.height);
         }
         super.setSize(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ISaleItemBlockRenderer = null;
         this.header = null;
         this.container = null;
         this.rendererBG = null;
         this.scrollingRenderrBg = null;
         if(this._elements)
         {
            this._elements.splice(0,this._elements.length);
            this._elements = null;
         }
         if(this._renderers)
         {
            for each(_loc1_ in this._renderers)
            {
               _loc1_.dispose();
            }
            this._renderers.length = 0;
            this._renderers = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.buttonMode = false;
         this.mouseChildren = true;
         if(_focusIndicator != null && !_focused && _focusIndicator.totalFrames == 1)
         {
            focusIndicator.visible = false;
         }
         if(this.container == null)
         {
            this.container = new Sprite();
            addChild(this.container);
         }
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA) && data)
         {
            this._renderers = this.createItemRenderers(this._elements.length);
            this.drawLayout();
            dispatchEvent(new VehicleSellDialogEvent(VehicleSellDialogEvent.SELL_DIALOG_LIST_ITEM_RENDERER_WAS_DRAWN));
         }
         super.draw();
      }
      
      public function getRenderers() : Vector.<ISaleItemBlockRenderer>
      {
         return this._renderers;
      }
      
      private function createItemRenderers(param1:Number) : Vector.<ISaleItemBlockRenderer>
      {
         var _loc2_:Vector.<ISaleItemBlockRenderer> = new Vector.<ISaleItemBlockRenderer>(0);
         var _loc3_:Number = 0;
         while(_loc3_ < param1)
         {
            _loc2_[_loc3_] = this.createItemRenderer();
            _loc3_++;
         }
         if(param1 > 0)
         {
            _loc2_[param1 - 1].hideLine();
         }
         return _loc2_;
      }
      
      private function createItemRenderer() : ISaleItemBlockRenderer
      {
         var _loc1_:ISaleItemBlockRenderer = App.utils.classFactory.getComponent(Linkages.SALE_ITEM_BLOCK_RENDERER,ISaleItemBlockRenderer);
         this.container.addChild(DisplayObject(_loc1_));
         return _loc1_;
      }
      
      private function drawLayout() : void
      {
         var _loc1_:uint = 41;
         var _loc2_:Number = 27;
         var _loc3_:int = Boolean(this._renderers) ? int(this._renderers.length) : int(0);
         var _loc4_:Number = _loc2_ * _loc3_ + _loc1_;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            this._renderers[_loc5_].x = 0;
            this._renderers[_loc5_].y = _loc1_ + _loc2_ * _loc5_ >> 0;
            this._renderers[_loc5_].setData(this._elements[_loc5_]);
            this._renderers[_loc5_].validateNow();
            _loc5_++;
         }
         this.height = _loc4_;
      }
   }
}
