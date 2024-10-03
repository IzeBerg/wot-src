package net.wg.gui.lobby.hangar
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.Directions;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.lobby.components.data.VehParamVO;
   import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
   import net.wg.infrastructure.base.meta.impl.VehicleParametersMeta;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.utils.Padding;
   
   public class VehicleParameters extends VehicleParametersMeta implements IVehicleParameters
   {
      
      private static const BOTTOM_SHADOW_OFFSET:int = 11;
      
      private static const TOP_SHADOW_OFFSET:int = 8;
      
      private static const BG_MARGIN:int = 20;
      
      private static const HALF_BG_MARGIN:int = BG_MARGIN >> 1;
      
      private static const SB_PADDING:Padding = new Padding(0,0,0,7);
      
      private static const HELP_LAYOUT_X_CORRECTION:int = 71;
      
      private static const HELP_LAYOUT_W_CORRECTION:int = 72;
      
      private static const RENDERER_HEIGHT:int = 24;
      
      private static const BG_WIDTH_BIG:int = 320;
      
      private static const BG_WIDTH_SMALL:int = 300;
      
      private static const LIST_MASK_WIDTH:int = 415;
      
      private static const INV_LIPS:String = "invLips";
      
      private static const INV_SEND_RESIZE:String = "invSendResize";
      
      private static const CHAR_UNDERSCORE:String = "_";
       
      
      public var paramsList:ScrollingListEx = null;
      
      public var bg:Sprite = null;
      
      public var rendererBG:Sprite = null;
      
      public var topShadow:Sprite = null;
      
      public var bottomShadow:Sprite = null;
      
      protected var _dataProvider:IDataProvider = null;
      
      private var _snapHeightToRenderers:Boolean = true;
      
      private var _helpLayoutId:String = null;
      
      private var _helpLayoutW:Number = 0;
      
      private var _isParamsAnimated:Boolean = true;
      
      private var _hasListeners:Boolean = false;
      
      private var _listMask:Sprite = null;
      
      private var _forceInvalidateOnDataChange:Boolean = true;
      
      private var _showShadowLipWhenOverflow:Boolean;
      
      private var _showBottomShadowLipAlways:Boolean = false;
      
      public function VehicleParameters()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.utils.helpLayout.registerComponent(this);
         this.paramsList.itemRenderer = App.utils.classFactory.getClass(this.getRendererLinkage());
         this.paramsList.scrollBar = Linkages.SCROLL_BAR;
         this.paramsList.smartScrollBar = true;
         this.paramsList.widthAutoResize = false;
         this.paramsList.sbPadding = SB_PADDING;
         this.paramsList.addEventListener(MouseEvent.MOUSE_WHEEL,this.onParamsListMouseWheelHandler);
         this.paramsList.addEventListener(ListEventEx.ITEM_CLICK,this.onParamsListItemClickHandler);
         this.paramsList.addEventListener(ListEventEx.ITEM_ROLL_OVER,this.onParamsListItemRollOverHandler);
         this.paramsList.addEventListener(MouseEvent.ROLL_OUT,this.onParamsListRollOutHandler);
         this.paramsList.addEventListener(Event.RESIZE,this.onParamsListResizedHandler);
         mouseEnabled = this.paramsList.mouseEnabled = this.bg.mouseEnabled = this.bg.mouseChildren = false;
         this.hideRendererBG();
         this.topShadow.mouseEnabled = this.topShadow.mouseChildren = false;
         this.bottomShadow.mouseEnabled = this.bottomShadow.mouseChildren = false;
         this.topShadow.visible = this.bottomShadow.visible = false;
         this._listMask = new Sprite();
         var _loc1_:Graphics = this._listMask.graphics;
         _loc1_.beginFill(0);
         _loc1_.drawRect(0,0,LIST_MASK_WIDTH,1);
         _loc1_.endFill();
         this._listMask.mouseEnabled = false;
         this._listMask.mouseChildren = false;
         addChild(this._listMask);
         this.paramsList.mask = this._listMask;
      }
      
      override protected function onBeforeDispose() : void
      {
         this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         if(this._hasListeners)
         {
            this.paramsList.scrollBar.removeEventListener(MouseEvent.MOUSE_DOWN,this.onParamsListScrollBarMouseDownHandler);
            this.paramsList.scrollBar.removeEventListener(MouseEvent.ROLL_OVER,this.onParamsListScrollBarRollOverHandler);
         }
         this.paramsList.removeEventListener(ListEventEx.ITEM_CLICK,this.onParamsListItemClickHandler);
         this.paramsList.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onParamsListMouseWheelHandler);
         this.paramsList.removeEventListener(ListEventEx.ITEM_ROLL_OVER,this.onParamsListItemRollOverHandler);
         this.paramsList.removeEventListener(MouseEvent.ROLL_OUT,this.onParamsListRollOutHandler);
         this.paramsList.removeEventListener(Event.RESIZE,this.onParamsListResizedHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.bg = null;
         this.rendererBG = null;
         this.topShadow = null;
         this.bottomShadow = null;
         this.paramsList.mask = null;
         this.paramsList.dispose();
         this.paramsList = null;
         this._listMask = null;
         this._dataProvider.cleanUp();
         this._dataProvider = null;
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._dataProvider = new ListDAAPIDataProvider(VehParamVO);
         this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         this.paramsList.dataProvider = this._dataProvider;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = RENDERER_HEIGHT * this._dataProvider.length;
            if(_loc1_ > height - BG_MARGIN)
            {
               _loc1_ = !!this._snapHeightToRenderers ? int(RENDERER_HEIGHT * ((height - BG_MARGIN) / RENDERER_HEIGHT ^ 0)) : int(height);
            }
            this.paramsList.height = _loc1_;
            this.paramsList.rowHeight = RENDERER_HEIGHT;
            this.paramsList.validateNow();
            this.bg.height = _loc1_ + BG_MARGIN;
            this._listMask.height = this.bg.height - HALF_BG_MARGIN;
            invalidate(INV_LIPS);
            invalidate(INV_SEND_RESIZE);
         }
         if(isInvalid(INV_LIPS))
         {
            if(!this._showShadowLipWhenOverflow)
            {
               this.topShadow.visible = this.bottomShadow.visible = false;
            }
            else
            {
               _loc1_ = this.paramsList.rowHeight * this.paramsList.dataProvider.length;
               _loc2_ = _loc1_ > height;
               this.topShadow.visible = this.bottomShadow.visible = _loc2_;
               this.updateLipsPosition();
            }
            if(this._showBottomShadowLipAlways && !this.bottomShadow.visible)
            {
               this.bottomShadow.visible = true;
               this.bottomShadow.y = this.paramsList.height + BOTTOM_SHADOW_OFFSET;
            }
         }
         if(!this._hasListeners)
         {
            this._hasListeners = true;
            this.paramsList.scrollBar.addEventListener(MouseEvent.MOUSE_DOWN,this.onParamsListScrollBarMouseDownHandler);
            this.paramsList.scrollBar.addEventListener(MouseEvent.ROLL_OVER,this.onParamsListScrollBarRollOverHandler);
         }
         if(isInvalid(INV_SEND_RESIZE))
         {
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      public function as_getDP() : Object
      {
         return this._dataProvider;
      }
      
      public function as_setIsParamsAnimated(param1:Boolean) : void
      {
         this._isParamsAnimated = param1;
      }
      
      public function getHelpLayoutWidth() : Number
      {
         return width;
      }
      
      public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         if(StringUtils.isEmpty(this._helpLayoutId))
         {
            this._helpLayoutId = name + CHAR_UNDERSCORE + Math.random();
         }
         var _loc1_:HelpLayoutVO = new HelpLayoutVO();
         _loc1_.x = HELP_LAYOUT_X_CORRECTION;
         _loc1_.y = 0;
         _loc1_.width = this._helpLayoutW - HELP_LAYOUT_W_CORRECTION;
         _loc1_.height = this.bg.height;
         _loc1_.extensibilityDirection = Directions.RIGHT;
         _loc1_.message = LOBBY_HELP.HANGAR_VEHICLE_PARAMETERS;
         _loc1_.id = this._helpLayoutId;
         _loc1_.scope = this;
         return new <HelpLayoutVO>[_loc1_];
      }
      
      public function hideBg() : void
      {
         this.bg.visible = false;
      }
      
      public function showHelpLayoutEx(param1:Number, param2:Number) : void
      {
         this._helpLayoutW = param2;
      }
      
      protected function getRendererLinkage() : String
      {
         return Linkages.VEH_PARAMS_RENDERER_UI;
      }
      
      protected function updateLipsPosition() : void
      {
         this.topShadow.y = TOP_SHADOW_OFFSET;
         this.bottomShadow.y = height + BOTTOM_SHADOW_OFFSET;
      }
      
      private function hideRendererBG() : void
      {
         if(this.rendererBG.visible)
         {
            this.rendererBG.visible = false;
            this.rendererBG.y = 0;
         }
      }
      
      public function set showShadowLipWhenOverflow(param1:Boolean) : void
      {
         if(this._showShadowLipWhenOverflow != param1)
         {
            this._showShadowLipWhenOverflow = param1;
            invalidate(INV_LIPS);
         }
      }
      
      public function set snapHeightToRenderers(param1:Boolean) : void
      {
         this._snapHeightToRenderers = param1;
      }
      
      public function set forceInvalidateOnDataChange(param1:Boolean) : void
      {
         this._forceInvalidateOnDataChange = param1;
      }
      
      public function set showBottomShadowLipAlways(param1:Boolean) : void
      {
         this._showBottomShadowLipAlways = param1;
         invalidate(INV_LIPS);
      }
      
      private function onParamsListItemRollOverHandler(param1:ListEventEx) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:IListItemRenderer = null;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc2_:VehParamVO = VehParamVO(param1.itemData);
         var _loc3_:String = _loc2_.state;
         if(_loc3_ == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_TOP || _loc3_ == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_BOTTOM || _loc3_ == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_ABILITY)
         {
            _loc4_ = this.rendererBG.visible;
            _loc5_ = this.rendererBG.y;
            _loc6_ = RENDERER_HEIGHT;
            _loc7_ = param1.itemRenderer.y;
            _loc8_ = null;
            _loc9_ = true;
            _loc10_ = param1.index - this.paramsList.scrollPosition;
            _loc11_ = _loc2_.paramID;
            if(_loc10_ > 0)
            {
               _loc8_ = this.paramsList.getRendererAt(_loc10_ - 1);
               if(_loc11_ == VehParamVO(_loc8_.getData()).paramID)
               {
                  _loc7_ = _loc8_.y;
                  _loc6_ = RENDERER_HEIGHT << 1;
                  _loc9_ = false;
               }
            }
            if(_loc9_ && _loc10_ < this.paramsList.renderersCount - 1)
            {
               _loc8_ = this.paramsList.getRendererAt(_loc10_ + 1);
               if(_loc11_ == VehParamVO(_loc8_.getData()).paramID)
               {
                  _loc6_ = RENDERER_HEIGHT << 1;
               }
            }
            this.rendererBG.width = !!DisplayObject(this.paramsList.scrollBar).visible ? Number(BG_WIDTH_SMALL) : Number(BG_WIDTH_BIG);
            _loc12_ = _loc7_ + this.paramsList.y;
            this.rendererBG.y = _loc12_;
            this.rendererBG.height = _loc6_;
            this.rendererBG.visible = true;
            if(!_loc4_ || _loc5_ != _loc12_)
            {
               App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.ITEM_RDR,null);
            }
         }
         else
         {
            this.hideRendererBG();
         }
      }
      
      private function onParamsListRollOutHandler(param1:MouseEvent) : void
      {
         this.hideRendererBG();
      }
      
      private function onParamsListResizedHandler(param1:Event) : void
      {
         invalidate(INV_SEND_RESIZE);
      }
      
      private function onParamsListScrollBarRollOverHandler(param1:MouseEvent) : void
      {
         this.hideRendererBG();
      }
      
      private function onParamsListScrollBarMouseDownHandler(param1:MouseEvent) : void
      {
         this.hideRendererBG();
         if(this._isParamsAnimated)
         {
            onListScrollS();
         }
      }
      
      private function onParamsListMouseWheelHandler(param1:MouseEvent) : void
      {
         this.hideRendererBG();
         if(this._isParamsAnimated)
         {
            onListScrollS();
         }
      }
      
      private function onParamsListItemClickHandler(param1:ListEventEx) : void
      {
         App.toolTipMgr.hide();
         this.hideRendererBG();
         onParamClickS(VehParamVO(param1.itemData).paramID);
         invalidateSize();
      }
      
      private function onDataProviderChangeHandler(param1:Event) : void
      {
         if(this._dataProvider.length > 0 && (this.paramsList.renderersCount > 0 || this._forceInvalidateOnDataChange))
         {
            invalidateSize();
         }
      }
   }
}
