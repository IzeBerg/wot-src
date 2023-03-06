package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet
{
   import fl.motion.easing.Exponential;
   import fl.motion.easing.Quintic;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet.CustomizationPropertiesSheetVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class CustomizationSheetElementControls extends UIComponentEx
   {
      
      private static const NOT_ENOUGH_CONTENT_ASSERT:String = "Not enough renders for content in properties sheet";
      
      public static const CONTENT_POSITION_MIDDLE:int = 1;
      
      public static const CONTENT_POSITION_TOP:int = 2;
      
      public static const CONTENT_POSITION_BOTTOM:int = 3;
      
      public static const RENDERER_POSITION_TOP:int = 1;
      
      public static const RENDERER_POSITION_TOP_INTERMEDIATE:int = 2;
      
      public static const RENDERER_POSITION_MIDDLE:int = 3;
      
      public static const RENDERER_POSITION_BOTTOM_INTERMEDIATE:int = 4;
      
      public static const RENDERER_POSITION_BOTTOM:int = 5;
      
      private static const PART_BOOFER:int = 1;
      
      private static const START_BY_ZERO_RENDERERS_COUNT:int = 4;
      
      private static const HALF_LAYOUT_RENDERERS_COUNT:int = 3;
      
      private static const MAX_RENDERERS_COUNT:int = 5;
      
      private static const ZERO_RADIUS_GAP:int = 2;
      
      private static const LAYOUT_RADIUS:int = 100;
      
      private static const LAYOUT_BIG_RADIUS:int = 122;
      
      private static const LAYOUT_VERY_BIG_RADIUS:int = 140;
      
      private static const MAX_RENDERERS_LAYOUT_COUNT:int = 6;
      
      private static const ANIMATION_DURATION:int = 300;
      
      private static const ANIMATION_DURATION_HIDE:int = 150;
      
      private static const ANIMATION_DURATION_ALPHA_HIDE:int = 110;
      
      private static const MIN_RENDERERS_TO_MOUSEMASK:int = 2;
      
      private static const MOUSEMASK_OFFSET:int = -40;
      
      private static const MOUSEMASK_POINTS_OFFSET:int = 20;
       
      
      public var first:CustomizationSheetContentRenderer = null;
      
      public var second:CustomizationSheetContentRenderer = null;
      
      public var third:CustomizationSheetContentRenderer = null;
      
      public var fourth:CustomizationSheetContentRenderer = null;
      
      public var fifth:CustomizationSheetContentRenderer = null;
      
      public var six:CustomizationSheetContentRenderer = null;
      
      public var seventh:CustomizationSheetContentRenderer = null;
      
      private var _contentRenderers:Vector.<CustomizationSheetContentRenderer> = null;
      
      private var _tweens:Vector.<Tween>;
      
      private var _activeRenderersCount:int = -1;
      
      private var _oldActiveRenderersCount:int = -1;
      
      private var _layoutingRenderersCount:int = -1;
      
      private var _isBigRadius:Boolean = false;
      
      private var _isAfterOpen:Boolean = true;
      
      private var _hideElementsAnimationsCount:int = 0;
      
      private var _oldActionTypes:Vector.<int>;
      
      private var _oldRenderersPositions:Vector.<Point>;
      
      private var _rendererStates:Array;
      
      private var _contentStates:Array;
      
      public function CustomizationSheetElementControls()
      {
         this._tweens = new Vector.<Tween>(0);
         this._oldActionTypes = new Vector.<int>();
         this._oldRenderersPositions = new Vector.<Point>();
         this._rendererStates = [[RENDERER_POSITION_MIDDLE],[RENDERER_POSITION_TOP_INTERMEDIATE,RENDERER_POSITION_BOTTOM_INTERMEDIATE],[RENDERER_POSITION_TOP,RENDERER_POSITION_MIDDLE,RENDERER_POSITION_BOTTOM],[RENDERER_POSITION_TOP,RENDERER_POSITION_TOP_INTERMEDIATE,RENDERER_POSITION_BOTTOM_INTERMEDIATE,RENDERER_POSITION_BOTTOM],[RENDERER_POSITION_TOP,RENDERER_POSITION_TOP_INTERMEDIATE,RENDERER_POSITION_MIDDLE,RENDERER_POSITION_BOTTOM_INTERMEDIATE,RENDERER_POSITION_BOTTOM],[RENDERER_POSITION_TOP,RENDERER_POSITION_TOP_INTERMEDIATE,RENDERER_POSITION_TOP_INTERMEDIATE,RENDERER_POSITION_BOTTOM_INTERMEDIATE,RENDERER_POSITION_BOTTOM_INTERMEDIATE,RENDERER_POSITION_BOTTOM],[RENDERER_POSITION_TOP,RENDERER_POSITION_TOP_INTERMEDIATE,RENDERER_POSITION_TOP_INTERMEDIATE,RENDERER_POSITION_BOTTOM_INTERMEDIATE,RENDERER_POSITION_BOTTOM_INTERMEDIATE,RENDERER_POSITION_BOTTOM,RENDERER_POSITION_BOTTOM]];
         this._contentStates = [[CONTENT_POSITION_MIDDLE],[CONTENT_POSITION_BOTTOM,CONTENT_POSITION_TOP],[CONTENT_POSITION_BOTTOM,CONTENT_POSITION_MIDDLE,CONTENT_POSITION_TOP],[CONTENT_POSITION_BOTTOM,CONTENT_POSITION_MIDDLE,CONTENT_POSITION_MIDDLE,CONTENT_POSITION_TOP],[CONTENT_POSITION_BOTTOM,CONTENT_POSITION_BOTTOM,CONTENT_POSITION_MIDDLE,CONTENT_POSITION_MIDDLE,CONTENT_POSITION_TOP],[CONTENT_POSITION_BOTTOM,CONTENT_POSITION_BOTTOM,CONTENT_POSITION_MIDDLE,CONTENT_POSITION_MIDDLE,CONTENT_POSITION_MIDDLE,CONTENT_POSITION_TOP],[CONTENT_POSITION_BOTTOM,CONTENT_POSITION_BOTTOM,CONTENT_POSITION_MIDDLE,CONTENT_POSITION_MIDDLE,CONTENT_POSITION_MIDDLE,CONTENT_POSITION_TOP,CONTENT_POSITION_TOP]];
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._contentRenderers = new Vector.<CustomizationSheetContentRenderer>();
         this._contentRenderers.push(this.first);
         this._contentRenderers.push(this.second);
         this._contentRenderers.push(this.third);
         this._contentRenderers.push(this.fourth);
         this._contentRenderers.push(this.fifth);
         this._contentRenderers.push(this.six);
         this._contentRenderers.push(this.seventh);
         visible = false;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._contentRenderers)
         {
            _loc1_.dispose();
         }
         this._contentRenderers.splice(0,this._contentRenderers.length);
         this._contentRenderers = null;
         graphics.clear();
         this.clearTweens();
         this._tweens = null;
         this.clearOldPositionsArrays();
         this._oldActionTypes = null;
         this._oldRenderersPositions = null;
         this.first = null;
         this.second = null;
         this.third = null;
         this.fourth = null;
         super.onDispose();
      }
      
      public function hideElementsAnimation() : void
      {
         var _loc1_:MovieClip = null;
         this._isAfterOpen = true;
         this._layoutingRenderersCount = Values.DEFAULT_INT;
         graphics.clear();
         this.clearTweens();
         if(this._contentRenderers)
         {
            this._hideElementsAnimationsCount = this._contentRenderers.length;
         }
         for each(_loc1_ in this._contentRenderers)
         {
            this.animationHide(_loc1_);
         }
      }
      
      public function setRenderers(param1:CustomizationPropertiesSheetVO) : void
      {
         var _loc2_:CustomizationSheetContentRenderer = null;
         this.hideRenderers();
         this._isBigRadius = param1.isBigRadius;
         _loc2_ = null;
         var _loc3_:int = this._contentRenderers.length;
         this._oldActiveRenderersCount = this._activeRenderersCount;
         this._activeRenderersCount = param1.renderersData.length;
         var _loc4_:Class = null;
         var _loc5_:String = null;
         App.utils.asserter.assert(this._activeRenderersCount <= _loc3_,NOT_ENOUGH_CONTENT_ASSERT);
         this.clearOldPositionsArrays();
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc2_ = this._contentRenderers[_loc6_];
            this._oldActionTypes.push(_loc2_.actionType);
            this._oldRenderersPositions.push(new Point(_loc2_.x,_loc2_.y));
            if(_loc6_ < this._activeRenderersCount)
            {
               _loc5_ = param1.renderersData[_loc6_].rendererLnk;
               switch(_loc5_)
               {
                  case CUSTOMIZATION_ALIASES.CUSTOMIZATION_SHEET_BTN_RENDERER_UI:
                     _loc4_ = CustomizationSheetBtnRenderer;
                     break;
                  case CUSTOMIZATION_ALIASES.CUSTOMIZATION_SHEET_SCALE_COLOR_RENDERER_UI:
                     _loc4_ = CustomizationSheetScaleColorsRenderer;
                     break;
                  case CUSTOMIZATION_ALIASES.CUSTOMIZATION_SHEET_SWITCH_RENDERER_UI:
                     _loc4_ = CustomizationSheetSwitchRenderer;
               }
               _loc2_.setContent(param1.renderersData[_loc6_],_loc4_,_loc5_,this._isAfterOpen);
            }
            else
            {
               _loc2_.alpha = 0;
               _loc2_.x = 0;
               _loc2_.y = 0;
            }
            _loc6_++;
         }
         visible = true;
         if(this._activeRenderersCount != this._layoutingRenderersCount)
         {
            this.saveOldRenderersPositions();
            this.setPositions();
         }
         this._isAfterOpen = false;
      }
      
      private function hideRenderers() : void
      {
         var _loc1_:CustomizationSheetContentRenderer = null;
         for each(_loc1_ in this._contentRenderers)
         {
            _loc1_.visible = false;
         }
      }
      
      private function clearOldPositionsArrays() : void
      {
         this._oldActionTypes.splice(0,this._oldActionTypes.length);
         this._oldRenderersPositions.splice(0,this._oldRenderersPositions.length);
      }
      
      private function saveOldRenderersPositions() : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc1_:CustomizationSheetContentRenderer = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._activeRenderersCount)
         {
            _loc1_ = this._contentRenderers[_loc2_];
            _loc3_ = false;
            _loc4_ = 0;
            while(_loc4_ < this._oldActiveRenderersCount)
            {
               if(this._oldActionTypes[_loc4_] == _loc1_.actionType)
               {
                  _loc1_.x = this._oldRenderersPositions[_loc4_].x;
                  _loc1_.y = this._oldRenderersPositions[_loc4_].y;
                  _loc3_ = true;
                  break;
               }
               _loc4_++;
            }
            if(!_loc3_)
            {
               _loc1_.alpha = 0;
               _loc1_.x = 0;
               _loc1_.y = 0;
            }
            _loc3_ = false;
            _loc2_++;
         }
      }
      
      private function setPositions() : void
      {
         var _loc11_:Number = NaN;
         var _loc1_:int = this._activeRenderersCount + PART_BOOFER;
         _loc1_ = this._activeRenderersCount >= START_BY_ZERO_RENDERERS_COUNT ? int(_loc1_ - ZERO_RADIUS_GAP) : int(_loc1_);
         var _loc2_:Number = Math.PI / _loc1_;
         var _loc3_:Number = _loc2_;
         var _loc4_:Number = Math.PI / 2;
         var _loc5_:int = !!this._isBigRadius ? int(LAYOUT_BIG_RADIUS) : int(LAYOUT_RADIUS);
         _loc5_ = this._activeRenderersCount == MAX_RENDERERS_COUNT ? int(LAYOUT_BIG_RADIUS) : int(_loc5_);
         _loc5_ = this._activeRenderersCount < MAX_RENDERERS_LAYOUT_COUNT ? int(_loc5_) : int(LAYOUT_VERY_BIG_RADIUS);
         var _loc6_:int = Values.DEFAULT_INT;
         var _loc7_:int = Values.DEFAULT_INT;
         var _loc8_:int = Values.DEFAULT_INT;
         var _loc9_:int = Values.DEFAULT_INT;
         if(this._activeRenderersCount >= START_BY_ZERO_RENDERERS_COUNT)
         {
            _loc3_ = 0;
         }
         else if(this._activeRenderersCount == HALF_LAYOUT_RENDERERS_COUNT)
         {
            _loc11_ = _loc2_ / 2;
            _loc3_ = _loc11_;
            _loc2_ += _loc11_;
         }
         this.clearTweens();
         graphics.clear();
         graphics.beginFill(16711680,0);
         graphics.lineTo(MOUSEMASK_OFFSET,0);
         var _loc10_:int = 0;
         while(_loc10_ < this._activeRenderersCount)
         {
            _loc6_ = _loc5_ * Math.cos(_loc3_ - _loc4_);
            _loc7_ = _loc5_ * Math.sin(_loc3_ - _loc4_);
            _loc8_ = (_loc5_ + MOUSEMASK_POINTS_OFFSET) * Math.cos(_loc3_ - _loc4_);
            _loc9_ = (_loc5_ + MOUSEMASK_POINTS_OFFSET) * Math.sin(_loc3_ - _loc4_);
            graphics.lineTo(_loc8_,_loc9_);
            if(this._contentRenderers[_loc10_].x != _loc6_ || this._contentRenderers[_loc10_].y != _loc7_)
            {
               this._tweens.push(new Tween(ANIMATION_DURATION,this._contentRenderers[_loc10_],{
                  "x":_loc6_,
                  "y":_loc7_,
                  "alpha":1
               },{"ease":Quintic.easeOut}));
            }
            else
            {
               this._contentRenderers[_loc10_].alpha = 1;
            }
            this._contentRenderers[_loc10_].setLayout(this._contentStates[this._activeRenderersCount - 1][_loc10_],this._rendererStates[this._activeRenderersCount - 1][_loc10_]);
            _loc3_ += _loc2_;
            _loc10_++;
         }
         graphics.lineTo(MOUSEMASK_OFFSET,0);
         if(this._activeRenderersCount < MIN_RENDERERS_TO_MOUSEMASK || this._isBigRadius)
         {
            graphics.clear();
         }
         this._layoutingRenderersCount = this._activeRenderersCount;
      }
      
      private function visibleHide() : void
      {
         this._hideElementsAnimationsCount -= 1;
         if(this._hideElementsAnimationsCount <= 0)
         {
            visible = false;
            dispatchEvent(new CustomizationEvent(CustomizationEvent.ELEMENTS_CONROLS_HIDE));
         }
      }
      
      private function animationHide(param1:MovieClip) : void
      {
         this._tweens.push(new Tween(ANIMATION_DURATION_HIDE,param1,{
            "x":0,
            "y":0
         },{
            "ease":Exponential.easeIn,
            "onComplete":this.visibleHide
         }));
         this._tweens.push(new Tween(ANIMATION_DURATION_ALPHA_HIDE,param1,{"alpha":0},{"ease":Exponential.easeIn}));
      }
      
      private function clearTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.splice(0,this._tweens.length);
         this._hideElementsAnimationsCount = 0;
      }
   }
}
