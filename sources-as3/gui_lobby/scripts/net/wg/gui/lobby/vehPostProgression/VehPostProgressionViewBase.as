package net.wg.gui.lobby.vehPostProgression
{
   import fl.motion.BezierEase;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.components.VehicleTitle;
   import net.wg.gui.lobby.components.data.VehicleTitleVO;
   import net.wg.gui.lobby.vehPostProgression.components.VehParamsPanel;
   import net.wg.gui.lobby.vehPostProgression.components.VehicleBlock;
   import net.wg.gui.lobby.vehPostProgression.data.VehPostProgressionViewVO;
   import net.wg.gui.lobby.vehPostProgression.events.DemountAllBtnEvent;
   import net.wg.infrastructure.base.meta.IVehiclePostProgressionViewBaseMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePostProgressionViewBaseMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   
   public class VehPostProgressionViewBase extends VehiclePostProgressionViewBaseMeta implements IVehiclePostProgressionViewBaseMeta
   {
      
      private static const TITLE_CENTER_Y_OFFSET:int = -230;
      
      private static const TITLE_MIN_Y_VALUE:int = 80;
      
      private static const TITLE_SIZE_Y_FACTOR:int = 111;
      
      private static const MAX_PARAMS_MARGIN:int = 3;
      
      private static const FLAG_ALPHA:Number = 0.4;
      
      private static const FLAG_SCALE:Number = 0.65;
      
      private static const CONTENT_LEFT_MARGIN:int = 16;
      
      private static const VIEW_Y:int = 88;
      
      private static const TWEEN_SHOW_TIME:int = 200;
      
      private static const TWEEN_SHOW_DELAY:int = 100;
      
      private static const TWEEN_SHOW_POINTS:Array = [new Point(0.07,0.82),new Point(0.17,1)];
      
      private static const BG_OFFSET_X:int = -1131;
      
      private static const BG_OFFSET_Y:int = -654;
      
      private static const NATION_FLAGS_X_OFFSET:int = -50;
      
      private static const NATION_FLAGS_Y_OFFSET:int = -150;
      
      private static const VEHICLE_BLOCK_NAME:String = "VehicleBlock";
      
      private static const BG_H_MARGIN:int = 10;
       
      
      public var vehParamsPanel:VehParamsPanel = null;
      
      public var background:Image = null;
      
      public var footerBg:Sprite = null;
      
      public var title:VehicleTitle = null;
      
      public var nationFlags:MovieClip = null;
      
      public var bgColor:Sprite = null;
      
      protected var _vehicleBlock:VehicleBlock;
      
      protected var _vo:VehPostProgressionViewVO = null;
      
      private var _injectComponent:VehPostProgressionViewAdaptor;
      
      private var _tweenShow:Tween;
      
      public function VehPostProgressionViewBase()
      {
         this._vehicleBlock = new VehicleBlock();
         this._injectComponent = new VehPostProgressionViewAdaptor();
         super();
         addChild(this.vehParamsPanel);
         addChild(this._injectComponent);
         addChild(this._vehicleBlock);
         this._vehicleBlock.name = VEHICLE_BLOCK_NAME;
         addChild(this.title);
         this.contentAlpha = 0;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         setViewSize(param1,param2);
         invalidateSize();
      }
      
      override protected function onDispose() : void
      {
         this._vehicleBlock.dispose();
         this._vehicleBlock = null;
         this.title.dispose();
         this.title = null;
         this.footerBg = null;
         this.bgColor = null;
         this.vehParamsPanel.dispose();
         this.vehParamsPanel = null;
         this.background.dispose();
         this.background = null;
         this.nationFlags = null;
         this._injectComponent = null;
         this._vo = null;
         this._tweenShow.dispose();
         this._tweenShow = null;
         super.onDispose();
      }
      
      override protected function onBeforeDispose() : void
      {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
         this.background.removeEventListener(Event.CHANGE,this.onBackgroundChangeHandler);
         this.vehParamsPanel.removeEventListener(DemountAllBtnEvent.DEMOUNT_ALL_CLICK,this.onDemountAllClickHandler);
         super.onBeforeDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
         this.nationFlags.scaleX = this.nationFlags.scaleY = FLAG_SCALE;
         this.nationFlags.alpha = FLAG_ALPHA;
         this.background.cacheType = ImageCacheTypes.NOT_USE_CACHE;
         this.background.source = RES_ICONS.MAPS_ICONS_VEHPOSTPROGRESSION_VEHICLEPOSTPROGRESSIONVIEW_VEHPROGRESSIONBG;
         this.background.smoothing = true;
         this.background.addEventListener(Event.CHANGE,this.onBackgroundChangeHandler);
         this.vehParamsPanel.addEventListener(DemountAllBtnEvent.DEMOUNT_ALL_CLICK,this.onDemountAllClickHandler);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.vehParamsPanel.params,HANGAR_ALIASES.POST_PROGRESSION_VEHICLE_PARAMS);
         var _loc1_:BezierEase = new BezierEase();
         _loc1_.points = TWEEN_SHOW_POINTS;
         this._tweenShow = new Tween(TWEEN_SHOW_TIME,this,{
            "contentAlpha":1,
            "delay":TWEEN_SHOW_DELAY
         },{
            "ease":_loc1_.getValue,
            "paused":true
         });
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._vo && isInvalid(InvalidationType.DATA))
         {
            this._vehicleBlock.setButtonData(this._vo.vehicleButton);
            this._vehicleBlock.setVehicleInfo(this._vo.vehicleInfo);
            this._vehicleBlock.setExpBlockVisible(this._vo.showExpBlock);
            this._vehicleBlock.updateWalletStatus();
            this.vehParamsPanel.setDemountAllButtonLabel(this._vo.demountAllButtonLabel);
            if(this.nationFlags.currentFrameLabel != this._vo.nation)
            {
               this.nationFlags.gotoAndStop(this._vo.nation);
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateComponentsLayout();
         }
      }
      
      override protected function setVehicleTitle(param1:VehicleTitleVO) : void
      {
         this.title.setData(param1);
      }
      
      override protected function setData(param1:VehPostProgressionViewVO) : void
      {
         this._vo = param1;
         this.vehParamsPanel.showDemountAllPairsBtn = this._vo.showDemountAllPairsBtn;
         invalidateData();
      }
      
      public function as_onEscPressed() : void
      {
         this.onEscapeClickHandler();
      }
      
      public function as_show() : void
      {
         this._tweenShow.reset();
         this._tweenShow.paused = false;
      }
      
      protected function onEscapeClickHandler() : void
      {
      }
      
      private function updateComponentsLayout() : void
      {
         var _loc1_:SizeSetting = null;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         _loc1_ = SizeSettings.extraExtraSmall;
         var _loc2_:int = height + VIEW_Y;
         if(width >= SizeSettings.extraLarge.breakPointX && _loc2_ >= SizeSettings.extraLarge.breakPointY)
         {
            _loc1_ = SizeSettings.extraLarge;
         }
         else if(width >= SizeSettings.large.breakPointX && _loc2_ >= SizeSettings.large.breakPointY)
         {
            _loc1_ = SizeSettings.large;
         }
         else if(width >= SizeSettings.medium.breakPointX && _loc2_ >= SizeSettings.medium.breakPointY)
         {
            _loc1_ = SizeSettings.medium;
         }
         else if(width >= SizeSettings.small.breakPointX && _loc2_ >= SizeSettings.small.breakPointY)
         {
            _loc1_ = SizeSettings.small;
         }
         else if(width >= SizeSettings.extraSmall.breakPointX)
         {
            _loc1_ = SizeSettings.extraSmall;
         }
         this.title.x = width >> 1;
         var _loc3_:uint = (height >> 1) + TITLE_CENTER_Y_OFFSET >> 1;
         this.title.y = _loc3_ > TITLE_MIN_Y_VALUE ? Number(_loc3_) : Number(TITLE_MIN_Y_VALUE);
         this.title.isSmallSized = _loc3_ < TITLE_SIZE_Y_FACTOR;
         this.title.validateNow();
         this._vehicleBlock.size = _loc1_.sizePrefix;
         var _loc4_:int = _loc1_.injectCmpWidth;
         _loc5_ = _loc1_.injectCmpHeight;
         var _loc6_:Boolean = width < SizeSettings.extraSmall.breakPointX;
         this.vehParamsPanel.height = height;
         this.vehParamsPanel.allowHide = _loc6_;
         if(_loc6_)
         {
            addChild(this.vehParamsPanel);
         }
         else
         {
            addChildAt(this.vehParamsPanel,getChildIndex(this._injectComponent));
         }
         var _loc7_:Number = _loc4_ + this.vehParamsPanel.width;
         if(!_loc6_ && width - _loc7_ >= 0)
         {
            _loc9_ = (width - _loc7_ >> 1) + CONTENT_LEFT_MARGIN;
            this.vehParamsPanel.x = _loc9_ + _loc4_ + MAX_PARAMS_MARGIN;
            this._injectComponent.width = _loc4_ + _loc1_.injectCmpXMargin * 2;
            this._injectComponent.x = _loc9_ - _loc1_.injectCmpXMargin;
         }
         else
         {
            this._injectComponent.x = (width - _loc4_ >> 1) - _loc1_.injectCmpXMargin;
            this.vehParamsPanel.x = width - this.vehParamsPanel.width;
            this._injectComponent.width = _loc4_ + _loc1_.injectCmpXMargin * 2;
         }
         var _loc8_:Number = this.title.y + this.title.height - _loc1_.injectCmpTopOffset >> 0;
         this._injectComponent.y = _loc8_ + height - _loc5_ >> 1;
         this._injectComponent.height = height - this._injectComponent.y;
         this._vehicleBlock.x = this._injectComponent.x + (this._injectComponent.width >> 1);
         this._vehicleBlock.y = this._injectComponent.y + (_loc5_ >> 2) + _loc1_.vehicleTopOffset;
         this.vehParamsPanel.setParamsDimensions(this._injectComponent.y + _loc1_.vehParamsTopOffset,_loc5_ - _loc1_.vehParamsTopOffset);
         this.background.scaleX = this.background.scaleY = _loc1_.bgScale;
         this.background.x = this._vehicleBlock.x + BG_OFFSET_X * _loc1_.bgScale >> 0;
         this.background.y = this._vehicleBlock.y + BG_OFFSET_Y * _loc1_.bgScale >> 0;
         this.footerBg.width = _width;
         this.footerBg.y = _height;
         this.bgColor.x = -BG_H_MARGIN;
         this.bgColor.width = _width + BG_H_MARGIN * 2;
         this.bgColor.height = _height;
         this.nationFlags.x = Math.max(0,this._injectComponent.x + NATION_FLAGS_X_OFFSET);
         this.nationFlags.y = Math.max(0,this._injectComponent.y + NATION_FLAGS_Y_OFFSET);
      }
      
      public function get contentAlpha() : Number
      {
         return this._vehicleBlock.alpha;
      }
      
      public function set contentAlpha(param1:Number) : void
      {
         this._vehicleBlock.alpha = param1;
         this._injectComponent.alpha = param1;
      }
      
      public function get injectComponent() : VehPostProgressionViewAdaptor
      {
         return this._injectComponent;
      }
      
      private function onBackgroundChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onDemountAllClickHandler(param1:DemountAllBtnEvent) : void
      {
         demountAllPairsS();
      }
      
      private function handleEscape(param1:InputEvent) : void
      {
         if(this.vehParamsPanel.allowHide && this.vehParamsPanel.isPanelShown)
         {
            this.vehParamsPanel.hide();
         }
         else
         {
            this.onEscapeClickHandler();
         }
      }
   }
}
