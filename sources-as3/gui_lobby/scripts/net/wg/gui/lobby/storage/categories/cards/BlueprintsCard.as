package net.wg.gui.lobby.storage.categories.cards
{
   import fl.motion.easing.Cubic;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.lobby.storage.categories.blueprints.BlueprintCostRenderer;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.motion.Tween;
   
   public class BlueprintsCard extends UIComponentEx implements IStageSizeDependComponent, IScrollerItemRenderer, ISoundable
   {
      
      private static const FIRST_ANIMATION_DURATION:Number = 200;
      
      private static const ROLL_OVER_ANIMATION_DELAY:int = 0;
      
      private static const SELL_BUTTON_MIN_WIDTH:int = 90;
      
      private static const BORDER_OFFSET:Number = 0.5;
      
      private static const BORDER_CORNER_RADIUS:int = 2;
      
      private static const BORDER_SIZE_CORRECTION:Number = 2.5;
      
      private static const OVERLAY_SIZE_CORRECTION:int = 3;
      
      private static const DESCRIPTION_OFFSET_Y:int = 0;
      
      private static const FRAGMENTS_COUNT_OFFSET_Y:int = 4;
      
      private static const BG_SHINE_OFFSET_X:int = -1;
      
      private static const COST_HEGHT:int = 23;
      
      private static const PADDINGS_SMALL:Rectangle = new Rectangle(12,12,260 - 8 - 12 - 2,171 - 8 - 9 - 2);
      
      private static const IMAGE_SIZE_SMALL:Rectangle = new Rectangle(0,0,144,108);
      
      private static const PADDINGS_BIG:Rectangle = new Rectangle(12,12,312 - 14 - 12,205 - 11 - 13);
      
      private static const IMAGE_SIZE_BIG:Rectangle = new Rectangle(0,0,180,135);
      
      private static const BG_STATE_BIG:String = "big";
      
      private static const BG_STATE_SMALL:String = "small";
      
      private static const COST_GAP:int = -1;
      
      private static const COST_OFFSET_Y:int = -2;
      
      private static const INTELLIGENCE_COUNT_OFFSET_Y:int = 2;
      
      private static const TITLE_TO_COST_Y:int = 6;
      
      private static const ROLL_OUT_OFFSET_Y:int = -2;
      
      private static const COST_ROLL_OVER_OFFSET_Y:int = 30;
      
      private static const COST_ROLL_OVER_OFFSET_Y_SMALL:int = 30;
      
      private static const COST_OFFSET_Y_SMALL:int = -2;
      
      private static const CONT_ROLL_OVER_OFFSET_Y:int = 32;
      
      private static const CONT_ROLL_OVER_OFFSET_Y_SMALL:int = 22;
       
      
      public var titleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var image:Image = null;
      
      public var bgShine:MovieClip = null;
      
      public var plus:MovieClip = null;
      
      public var bgImage:MovieClip = null;
      
      public var fragmentsCountTF:TextField = null;
      
      public var treeIcon:MovieClip = null;
      
      public var navigateButton:SoundButtonEx = null;
      
      public var intelligenceCostTF:TextField = null;
      
      private var _data:BlueprintCardVO = null;
      
      private var _container:Sprite = null;
      
      private var _overlay:Sprite = null;
      
      private var _tweens:Vector.<Tween>;
      
      private var _isOver:Boolean = false;
      
      private var _index:uint = 0;
      
      private var _useSmallImage:Boolean = false;
      
      private var _fragmentsCostHolder:Sprite = null;
      
      private var _fragmentsCostItems:Vector.<BlueprintCostRenderer>;
      
      public function BlueprintsCard()
      {
         this._tweens = new Vector.<Tween>(0);
         this._fragmentsCostItems = new Vector.<BlueprintCostRenderer>(0);
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         alpha = 0;
         App.stageSizeMgr.register(this);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BlueprintCostRenderer = null;
         App.utils.scheduler.cancelTask(dispatchEvent);
         if(App.soundMgr != null)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this._data = null;
         this.navigateButton.dispose();
         this.navigateButton = null;
         this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.image.dispose();
         this.image = null;
         this.bgImage = null;
         this.titleTF = null;
         this.descriptionTF = null;
         this.disposeTweens();
         this._tweens = null;
         this._container = null;
         this._overlay = null;
         this.fragmentsCountTF = null;
         this.bgShine = null;
         this.plus = null;
         this.treeIcon = null;
         this.intelligenceCostTF = null;
         for each(_loc1_ in this._fragmentsCostItems)
         {
            _loc1_.dispose();
         }
         this._fragmentsCostItems.length = 0;
         this._fragmentsCostItems = null;
         this._fragmentsCostHolder = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         buttonMode = true;
         this._overlay = new Sprite();
         this._overlay.name = "overlay";
         this._overlay.alpha = 0;
         hitArea = this._overlay;
         this._container = new Sprite();
         this._container.name = "container";
         this._container.addChild(this.titleTF);
         this._container.addChild(this.descriptionTF);
         this._container.mouseEnabled = this._container.mouseChildren = false;
         this._fragmentsCostHolder = new Sprite();
         this._fragmentsCostHolder.name = "fragmentsCost";
         this._fragmentsCostHolder.mouseChildren = this._fragmentsCostHolder.mouseEnabled = false;
         this.titleTF.multiline = true;
         this.titleTF.wordWrap = true;
         this.titleTF.autoSize = TextFieldAutoSize.LEFT;
         this.descriptionTF.alpha = 0;
         this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         this.bgShine.mouseEnabled = this.bgShine.mouseChildren = false;
         this.bgImage.mouseEnabled = this.bgImage.mouseChildren = false;
         this.plus.mouseEnabled = this.plus.mouseChildren = false;
         this.image.mouseEnabled = this.image.mouseChildren = false;
         this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.navigateButton.alpha = 0;
         this.navigateButton.minWidth = SELL_BUTTON_MIN_WIDTH;
         this.navigateButton.autoSize = TextFieldAutoSize.RIGHT;
         this.navigateButton.label = STORAGE.BLUEPRINTS_BUTTONLABEL_GOTOBLUEPRINTS;
         this.treeIcon.mouseEnabled = this.treeIcon.mouseChildren = false;
         this.fragmentsCountTF.mouseEnabled = false;
         this.intelligenceCostTF.mouseEnabled = false;
         addChild(this._fragmentsCostHolder);
         addChild(this._container);
         addChildAt(this._overlay,0);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         if(App.soundMgr)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
         alpha = 1;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Vector.<BlueprintCardCostVO> = null;
         var _loc2_:int = 0;
         var _loc3_:BlueprintCardCostVO = null;
         var _loc4_:int = 0;
         var _loc5_:BlueprintCostRenderer = null;
         var _loc6_:int = 0;
         var _loc7_:Graphics = null;
         var _loc8_:Rectangle = null;
         var _loc9_:Rectangle = null;
         var _loc10_:int = 0;
         var _loc11_:BlueprintCostRenderer = null;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._data.title;
            this.descriptionTF.htmlText = this._data.description;
            this.fragmentsCountTF.htmlText = this._data.fragmentsProgress;
            this.intelligenceCostTF.htmlText = this._data.intelligenceCostText;
            this.treeIcon.visible = this._data.availableToUnlock;
            this.bgShine.visible = this._data.hasDiscount;
            this.plus.visible = this._data.convertAvailable;
            _loc1_ = this._data.fragmentsCost;
            _loc2_ = _loc1_.length;
            this._fragmentsCostHolder.visible = Boolean(_loc2_);
            if(_loc2_)
            {
               _loc4_ = this._fragmentsCostItems.length;
               _loc6_ = 0;
               while(_loc6_ < _loc2_)
               {
                  _loc3_ = _loc1_[_loc6_];
                  if(_loc6_ < _loc4_)
                  {
                     _loc5_ = this._fragmentsCostItems[_loc6_];
                     _loc5_.visible = true;
                     _loc5_.updateCostData(_loc3_);
                  }
                  else
                  {
                     _loc5_ = App.utils.classFactory.getComponent(Linkages.STORE_BLUEPRINT_COST_RENDERER,BlueprintCostRenderer);
                     _loc5_.updateCostData(_loc3_);
                     this._fragmentsCostItems.push(_loc5_);
                     this._fragmentsCostHolder.addChild(_loc5_);
                  }
                  _loc6_++;
               }
               _loc6_ = this._fragmentsCostItems.length - 1;
               while(_loc6_ >= _loc2_)
               {
                  this._fragmentsCostItems[_loc6_].visible = false;
                  _loc6_--;
               }
            }
            invalidateSize();
         }
         if(this._data && isInvalid(InvalidationType.SIZE))
         {
            if(this.image.source != this._data.image)
            {
               this.image.alpha = 0;
               this.image.sourceAlt = this._data.imageAlt;
               this.image.source = this._data.image;
            }
            _loc7_ = graphics;
            _loc7_.clear();
            _loc7_.lineStyle(1,16777215,0.15);
            _loc7_.beginFill(0,0.25);
            _loc7_.drawRoundRect(BORDER_OFFSET,BORDER_OFFSET,width - BORDER_SIZE_CORRECTION,height - BORDER_SIZE_CORRECTION,BORDER_CORNER_RADIUS,BORDER_CORNER_RADIUS);
            _loc7_.endFill();
            _loc7_ = this._overlay.graphics;
            _loc7_.clear();
            _loc7_.beginFill(1973272);
            _loc7_.drawRoundRect(1,1,width - OVERLAY_SIZE_CORRECTION,height - OVERLAY_SIZE_CORRECTION,BORDER_CORNER_RADIUS,BORDER_CORNER_RADIUS);
            _loc7_.endFill();
            _loc8_ = !!this._useSmallImage ? PADDINGS_SMALL : PADDINGS_BIG;
            _loc9_ = !!this._useSmallImage ? IMAGE_SIZE_SMALL : IMAGE_SIZE_BIG;
            this.bgImage.gotoAndStop(!!this._useSmallImage ? BG_STATE_SMALL : BG_STATE_BIG);
            if(_baseDisposed)
            {
               return;
            }
            this.titleTF.x = _loc8_.left | 0;
            this.titleTF.width = _loc8_.width | 0;
            if(!this._isOver)
            {
               this._container.y = this.getContainterRollOutY();
            }
            this.descriptionTF.x = _loc8_.left | 0;
            this.descriptionTF.y = this.titleTF.y + this.titleTF.height + DESCRIPTION_OFFSET_Y | 0;
            this.descriptionTF.width = _loc8_.width >> 0;
            this.navigateButton.x = _loc8_.right - this.navigateButton.width >> 0;
            this.navigateButton.y = _loc8_.bottom - this.navigateButton.height >> 0;
            this.onImageChange();
            this.treeIcon.x = _loc8_.right - this.treeIcon.width | 0;
            this.treeIcon.y = _loc8_.bottom - this.treeIcon.height | 0;
            this.bgShine.x = width - this.bgShine.width + BG_SHINE_OFFSET_X | 0;
            this.bgShine.y = 0;
            this.image.width = _loc9_.width | 0;
            this.image.height = _loc9_.height | 0;
            this.image.x = width - this.image.width >> 1;
            this.fragmentsCountTF.x = _loc8_.right - this.fragmentsCountTF.width | 0;
            this.fragmentsCountTF.y = _loc8_.top - FRAGMENTS_COUNT_OFFSET_Y | 0;
            this._fragmentsCostHolder.x = this.intelligenceCostTF.x = _loc8_.left | 0;
            this._fragmentsCostHolder.y = this.getFragmentsCostHolderY();
            this.intelligenceCostTF.y = this.getIntelligenceConstY(this._fragmentsCostHolder.y);
            _loc10_ = 0;
            for each(_loc11_ in this._fragmentsCostItems)
            {
               if(_loc11_.visible)
               {
                  _loc11_.x = _loc10_;
                  _loc10_ += _loc11_.width + COST_GAP;
               }
            }
            if(this.plus.visible)
            {
               this.plus.x = width - this.plus.width >> 1;
            }
         }
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return true;
      }
      
      public function getSoundId() : String
      {
         return null;
      }
      
      public function getSoundType() : String
      {
         return null;
      }
      
      public function measureSize(param1:Point = null) : Point
      {
         return null;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._useSmallImage = param1 < StageSizeBoundaries.WIDTH_1600;
         invalidateSize();
      }
      
      private function getIntelligenceConstY(param1:int) : int
      {
         return param1 - INTELLIGENCE_COUNT_OFFSET_Y - this.intelligenceCostTF.height;
      }
      
      private function getCostOffsetY() : int
      {
         return !!this._useSmallImage ? int(COST_OFFSET_Y_SMALL) : int(COST_OFFSET_Y);
      }
      
      private function getCostRolloverOffset() : int
      {
         return !!this._useSmallImage ? int(COST_ROLL_OVER_OFFSET_Y_SMALL) : int(COST_ROLL_OVER_OFFSET_Y);
      }
      
      private function startRollOverTweens() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = height - this._container.height - ROLL_OUT_OFFSET_Y - this.getCostRolloverOffset() - (!!this._useSmallImage ? CONT_ROLL_OVER_OFFSET_Y_SMALL : CONT_ROLL_OVER_OFFSET_Y) >> 1;
         if(this.navigateButton.visible && _loc1_ + this._container.height > this.navigateButton.y)
         {
            _loc1_ = this.navigateButton.y - this._container.height - ROLL_OUT_OFFSET_Y >> 1;
         }
         _loc2_ = this.getFragmentsCostHolderY() - this.getCostRolloverOffset() | 0;
         var _loc3_:int = this.getIntelligenceConstY(_loc2_);
         this.disposeTweens();
         this._tweens.push(new Tween(FIRST_ANIMATION_DURATION,this._container,{"y":_loc1_},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY,
            "ease":Cubic.easeInOut
         }),new Tween(FIRST_ANIMATION_DURATION,this._overlay,{"alpha":1},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY,
            "ease":Cubic.easeInOut
         }),new Tween(FIRST_ANIMATION_DURATION,this.image,{"alpha":0.2},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY,
            "ease":Cubic.easeInOut
         }),new Tween(0.5 * FIRST_ANIMATION_DURATION,this.descriptionTF,{"alpha":1},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY + 0.5 * FIRST_ANIMATION_DURATION,
            "ease":Cubic.easeInOut
         }),new Tween(FIRST_ANIMATION_DURATION,this.navigateButton,{"alpha":1},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY + FIRST_ANIMATION_DURATION,
            "ease":Cubic.easeInOut
         }),new Tween(FIRST_ANIMATION_DURATION,this.bgImage,{"alpha":0.2},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY,
            "ease":Cubic.easeInOut
         }),new Tween(FIRST_ANIMATION_DURATION,this._fragmentsCostHolder,{"y":_loc2_},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY,
            "ease":Cubic.easeInOut
         }),new Tween(FIRST_ANIMATION_DURATION,this.intelligenceCostTF,{"y":_loc3_},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY,
            "ease":Cubic.easeInOut
         }));
         if(this.treeIcon.visible)
         {
            this._tweens.push(new Tween(FIRST_ANIMATION_DURATION,this.treeIcon,{"alpha":0},{
               "fastTransform":false,
               "delay":ROLL_OVER_ANIMATION_DELAY,
               "ease":Cubic.easeInOut
            }));
         }
      }
      
      private function getContainterRollOutY() : int
      {
         return this.getFragmentsCostHolderY() - INTELLIGENCE_COUNT_OFFSET_Y - this.intelligenceCostTF.height - this.titleTF.height - TITLE_TO_COST_Y;
      }
      
      private function getFragmentsCostHolderY() : int
      {
         return (!!this._useSmallImage ? PADDINGS_SMALL.bottom : PADDINGS_BIG.bottom) - COST_HEGHT - this.getCostOffsetY();
      }
      
      private function startRollOutTweens() : void
      {
         var _loc1_:int = 0;
         this.disposeTweens();
         _loc1_ = this.getFragmentsCostHolderY();
         var _loc2_:int = _loc1_ - INTELLIGENCE_COUNT_OFFSET_Y - this.intelligenceCostTF.height;
         this._tweens.push(new Tween(0.5 & FIRST_ANIMATION_DURATION,this.descriptionTF,{"alpha":0},{
            "fastTransform":false,
            "ease":Cubic.easeInOut
         }),new Tween(FIRST_ANIMATION_DURATION,this._container,{"y":this.getContainterRollOutY()},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,this._overlay,{"alpha":0},{
            "fastTransform":false,
            "ease":Cubic.easeInOut
         }),new Tween(FIRST_ANIMATION_DURATION,this.image,{"alpha":1},{
            "fastTransform":false,
            "ease":Cubic.easeInOut
         }),new Tween(FIRST_ANIMATION_DURATION,this.navigateButton,{"alpha":0},{
            "fastTransform":false,
            "ease":Cubic.easeInOut
         }),new Tween(FIRST_ANIMATION_DURATION,this.bgImage,{"alpha":1},{
            "fastTransform":false,
            "ease":Cubic.easeInOut
         }),new Tween(FIRST_ANIMATION_DURATION,this._fragmentsCostHolder,{"y":_loc1_},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY,
            "ease":Cubic.easeInOut
         }),new Tween(FIRST_ANIMATION_DURATION,this.intelligenceCostTF,{"y":_loc2_},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY,
            "ease":Cubic.easeInOut
         }));
         if(this.treeIcon.visible)
         {
            this._tweens.push(new Tween(FIRST_ANIMATION_DURATION,this.treeIcon,{"alpha":1},{
               "fastTransform":false,
               "ease":Cubic.easeInOut
            }));
         }
      }
      
      private function animateImage() : void
      {
         if(!this._isOver && this.image.alpha != 1)
         {
            this._tweens.push(new Tween(FIRST_ANIMATION_DURATION,this.image,{"alpha":1},{"fastTransform":false}));
         }
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.length = 0;
      }
      
      private function onImageChange() : void
      {
         if(this.image.ready)
         {
            this.animateImage();
            invalidateSize();
         }
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get owner() : UIComponent
      {
         return null;
      }
      
      public function set owner(param1:UIComponent) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:BlueprintCardVO = param1 as BlueprintCardVO;
         if(this._data && this._data.isEqual(_loc2_))
         {
            return;
         }
         this._data = _loc2_;
         invalidateData();
      }
      
      public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
      }
      
      public function set isViewPortEnabled(param1:Boolean) : void
      {
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this._isOver = true;
         this.startRollOverTweens();
         App.utils.scheduler.scheduleTask(dispatchEvent,ROLL_OVER_ANIMATION_DELAY,new CardEvent(CardEvent.PLAY_INFO_SOUND));
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._isOver = false;
         this.startRollOutTweens();
         App.utils.scheduler.cancelTask(dispatchEvent);
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(this._data == null)
         {
            return;
         }
         var _loc2_:ICommons = App.utils.commons;
         if(_loc2_.isRightButton(param1))
         {
            if(this._data.contextMenuId)
            {
               dispatchEvent(new CardEvent(CardEvent.SHOW_CONTEXT_MENU,this._data));
            }
         }
         else
         {
            dispatchEvent(new CardEvent(CardEvent.SELL,this._data));
         }
      }
      
      private function onImageChangeHandler(param1:Event = null) : void
      {
         this.onImageChange();
      }
   }
}
