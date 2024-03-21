package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.vehiclePreview.VehiclePreviewEvent;
   import net.wg.gui.lobby.vehiclePreview.data.VPSetItemVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class SetItemsBlock extends UIComponentEx implements IPopOverCaller
   {
      
      public static const BLOCK_HEIGHT:int = 60;
      
      private static const BLOCK_ITEM_WIDTH:int = 48;
      
      private static const BLOCK_ITEM_GAP:int = 4;
      
      private static const BLOCK_ITEM_OFFSET:int = 8;
      
      private static const ICON_ITEM_OFFSET:int = BLOCK_ITEM_OFFSET - 6;
      
      private static const HOVER_ANIMATION_DURATION:int = 300;
      
      private static const DISABLED_ALPHA:Number = 0.5;
       
      
      public var hover:MovieClip = null;
      
      public var topText:TextField = null;
      
      private var _data:Vector.<VPSetItemVO>;
      
      private var _renderer:Vector.<SetItemRenderer>;
      
      private var _rendererToData:Dictionary;
      
      private var _hoverTween:Tween;
      
      private var _topTitle:String;
      
      private var _topTitleSmall:String;
      
      public function SetItemsBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:SetItemRenderer = null;
         this.disposeHoverTween();
         this._data = null;
         for each(_loc1_ in this._renderer)
         {
            this.disposeRenderer(_loc1_);
         }
         this._renderer.length = 0;
         this._renderer = null;
         this._rendererToData = null;
         this.hover = null;
         this.topText = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._renderer = new Vector.<SetItemRenderer>(0);
         this._rendererToData = new Dictionary();
         mouseEnabled = false;
         this.hover.alpha = 0;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Graphics = null;
         var _loc5_:SetItemRenderer = null;
         var _loc6_:VPSetItemVO = null;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.hover.visible = false;
            _loc1_ = this._data.length;
            _loc2_ = BLOCK_ITEM_WIDTH + BLOCK_ITEM_GAP;
            _loc3_ = _loc1_ * _loc2_ + BLOCK_ITEM_OFFSET * 2 - BLOCK_ITEM_GAP;
            _loc4_ = graphics;
            _loc4_.clear();
            _loc4_.lineStyle(1,16777215,0.15);
            _loc4_.beginFill(0,0.4);
            _loc4_.drawRoundRect(0.5,0.5,_loc3_,BLOCK_HEIGHT,2,2);
            _loc4_.endFill();
            _loc7_ = this._renderer.length;
            _loc8_ = 0;
            while(_loc8_ < _loc1_)
            {
               _loc6_ = this._data[_loc8_];
               if(_loc8_ < _loc7_)
               {
                  _loc5_ = this._renderer[_loc8_];
               }
               else
               {
                  _loc5_ = this.getNewRenderer();
               }
               this._rendererToData[_loc5_] = _loc6_;
               _loc5_.setData(_loc6_);
               _loc5_.x = ICON_ITEM_OFFSET + _loc8_ * _loc2_;
               if(_loc6_.rawData)
               {
                  this.hover.visible = true;
               }
               _loc8_++;
            }
            while(_loc7_-- > _loc1_)
            {
               this.disposeRenderer(this._renderer.pop());
            }
            setSize(_loc3_,BLOCK_HEIGHT);
            this.topText.htmlText = this._topTitle;
            if(this.topText.textWidth > _loc3_)
            {
               this.topText.htmlText = this._topTitleSmall;
            }
            this.topText.width = _loc3_;
            this.topText.x = 0;
            if(this.hover.visible)
            {
               this.hover.width = width - this.hover.x * 2;
               this.hover.height = BLOCK_HEIGHT - this.hover.y * 2;
            }
         }
      }
      
      public function getHitArea() : DisplayObject
      {
         return this;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this;
      }
      
      public function setData(param1:Vector.<VPSetItemVO>, param2:String, param3:String) : void
      {
         if(this._data != param1)
         {
            this._data = param1;
            this._topTitle = param2;
            this._topTitleSmall = param3;
            invalidateData();
            validateNow();
         }
      }
      
      private function disposeHoverTween() : void
      {
         if(this._hoverTween)
         {
            this._hoverTween.paused = true;
            this._hoverTween.dispose();
         }
      }
      
      private function getNewRenderer() : SetItemRenderer
      {
         var _loc1_:SetItemRenderer = SetItemRenderer(App.utils.classFactory.getObject(Linkages.SET_ITEM_RENDERER_UI));
         _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         _loc1_.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         _loc1_.name = "renderer_" + this._renderer.push(_loc1_);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function disposeRenderer(param1:SetItemRenderer) : void
      {
         param1.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         param1.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         param1.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         param1.dispose();
         removeChild(param1);
         delete this._rendererToData[param1];
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         alpha = !!param1 ? Number(Values.DEFAULT_ALPHA) : Number(DISABLED_ALPHA);
         super.enabled = param1;
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SetItemRenderer = SetItemRenderer(param1.currentTarget);
         var _loc3_:VPSetItemVO = this._rendererToData[_loc2_];
         if(_loc3_.rawData != null)
         {
            App.popoverMgr.show(this,Aliases.PACK_ITEM_POPOVER,_loc3_.rawData);
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:SetItemRenderer = SetItemRenderer(param1.currentTarget);
         var _loc3_:VPSetItemVO = this._rendererToData[_loc2_];
         dispatchEvent(new VehiclePreviewEvent(VehiclePreviewEvent.SHOW_TOOLTIP,_loc3_));
         if(this.hover.visible)
         {
            this._hoverTween = new Tween(HOVER_ANIMATION_DURATION,this.hover,{"alpha":1});
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
         if(this.hover.visible)
         {
            this._hoverTween = new Tween(HOVER_ANIMATION_DURATION,this.hover,{"alpha":0});
         }
      }
   }
}
