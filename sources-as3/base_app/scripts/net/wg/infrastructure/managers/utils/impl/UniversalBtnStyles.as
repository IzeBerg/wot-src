package net.wg.infrastructure.managers.utils.impl
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.utils.Dictionary;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.data.vo.UniversalBtnStyledDisplayObjects;
   import net.wg.data.vo.UniversalStyle;
   import net.wg.infrastructure.events.UniversalBtnEvent;
   import net.wg.infrastructure.interfaces.IUniversalBtn;
   import net.wg.infrastructure.interfaces.IUniversalBtnToggleIndicator;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.IUniversalBtnStyledDisplayObjects;
   import net.wg.utils.IUniversalBtnStyles;
   import net.wg.utils.IUniversalStyle;
   
   public class UniversalBtnStyles implements IUniversalBtnStyles
   {
      
      private static const UP:String = "up";
      
      private static const OVER:String = "over";
      
      private static const OUT:String = "out";
      
      private static const DOWN:String = "down";
      
      private static const RELEASE:String = "release";
      
      private static const DISABLED:String = "disabled";
      
      private static const HEAVY_STATES_NY_TRANSPARENT_LINKAGE:String = "UniHeavyNYTransparentStatesUI";
      
      private static const SLIM_STATES_NY_TRANSPARENT_LINKAGE:String = "UniSlimNYTransparentStatesUI";
      
      private static const HEAVY_STATES_BLACK_LINKAGE:String = "UniHeavyBlackStatesUI";
      
      private static const HEAVY_STATES_GREEN_LINKAGE:String = "UniHeavyGreenStatesUI";
      
      private static const HEAVY_STATES_ORANGE_LINKAGE:String = "UniHeavyOrangeStatesUI";
      
      private static const HEAVY_STATES_LIME_LINKAGE:String = "UniHeavyLimeStatesUI";
      
      private static const SLIM_STATES_BLACK_LINKAGE:String = "UniSlimBlackStatesUI";
      
      private static const SLIM_STATES_ORANGE_LINKAGE:String = "UniSlimOrangeStatesUI";
      
      private static const SLIM_STATES_GREEN_LINKAGE:String = "UniSlimGreenStatesUI";
      
      private static const SLIM_STATES_RED_LINKAGE:String = "UniSlimRedStatesUI";
      
      private static const SLIM_STATES_LIME_LINKAGE:String = "UniSlimLimeStatesUI";
      
      private static const DISABLE_FILL_BMD_LINKAGE:String = "uniDisablePattern";
      
      private static const SLIM_TOGGLE_INDICATOR_LINKAGE:String = "UniSlimBlackToggleIndicatorUI";
      
      private static const SLIM_TOGGLE_GLOW_LINKAGE:String = "UniSlimBlackToggleGlowUI";
      
      private static const OBJECT_NAME_SKIN:String = "skin";
      
      private static const OBJECT_NAME_TOGGLE_GLOW:String = "toggleGlow";
      
      private static const OBJECT_NAME_TOGGLE_INDICATOR:String = "toggleIndicator";
      
      private static const TF_COLOR:uint = 16711404;
      
      private static const TF_COLOR_NY:uint = 13434879;
      
      private static const STATES_ORANGE_SHADOW_FILTER:DropShadowFilter = new DropShadowFilter(1,270,6684672,1,1,1,1,0,false,false,false);
      
      private static const STATES_BASIC_SHADOW_FILTER:DropShadowFilter = new DropShadowFilter(1,270,0,1,1,1,1,0,false,false,false);
      
      private static const TF_SIZE_SLIM:uint = 13;
      
      private static const TF_SIZE_HEAVY:uint = 15;
      
      private static const TF_SIZE_NY_HEAVY:uint = 14;
       
      
      private var _styles:Dictionary = null;
      
      private var _classFactory:IClassFactory = null;
      
      private var _disposed:Boolean = false;
      
      public function UniversalBtnStyles()
      {
         super();
         this._styles = new Dictionary();
         var _loc1_:Dictionary = createTextAlphaStates(1,1,1,1,1,0.6);
         this._styles[UniversalBtnStylesConst.STYLE_SLIM_BLACK] = new UniversalStyle(SLIM_STATES_BLACK_LINKAGE,DISABLE_FILL_BMD_LINKAGE,SLIM_TOGGLE_INDICATOR_LINKAGE,SLIM_TOGGLE_GLOW_LINKAGE,TF_SIZE_SLIM,TF_COLOR,_loc1_,STATES_BASIC_SHADOW_FILTER);
         var _loc2_:Dictionary = createTextAlphaStates(1,1,1,1,1,0.6);
         this._styles[UniversalBtnStylesConst.STYLE_SLIM_ORANGE] = new UniversalStyle(SLIM_STATES_ORANGE_LINKAGE,DISABLE_FILL_BMD_LINKAGE,SLIM_TOGGLE_INDICATOR_LINKAGE,SLIM_TOGGLE_GLOW_LINKAGE,TF_SIZE_SLIM,TF_COLOR,_loc2_,STATES_ORANGE_SHADOW_FILTER);
         var _loc3_:Dictionary = createTextAlphaStates(1,1,1,1,1,0.6);
         this._styles[UniversalBtnStylesConst.STYLE_SLIM_GREEN] = new UniversalStyle(SLIM_STATES_GREEN_LINKAGE,DISABLE_FILL_BMD_LINKAGE,SLIM_TOGGLE_INDICATOR_LINKAGE,SLIM_TOGGLE_GLOW_LINKAGE,TF_SIZE_SLIM,TF_COLOR,_loc3_,STATES_BASIC_SHADOW_FILTER);
         var _loc4_:Dictionary = createTextAlphaStates(1,1,1,1,1,0.6);
         this._styles[UniversalBtnStylesConst.STYLE_SLIM_RED] = new UniversalStyle(SLIM_STATES_RED_LINKAGE,DISABLE_FILL_BMD_LINKAGE,SLIM_TOGGLE_INDICATOR_LINKAGE,SLIM_TOGGLE_GLOW_LINKAGE,TF_SIZE_SLIM,TF_COLOR,_loc4_,STATES_BASIC_SHADOW_FILTER);
         var _loc5_:Dictionary = createTextAlphaStates(1,1,1,1,1,0.6);
         this._styles[UniversalBtnStylesConst.STYLE_SLIM_LIME] = new UniversalStyle(SLIM_STATES_LIME_LINKAGE,DISABLE_FILL_BMD_LINKAGE,SLIM_TOGGLE_INDICATOR_LINKAGE,SLIM_TOGGLE_GLOW_LINKAGE,TF_SIZE_SLIM,TF_COLOR,_loc5_,STATES_BASIC_SHADOW_FILTER);
         var _loc6_:Dictionary = createTextAlphaStates(1,1,1,1,1,0.6);
         this._styles[UniversalBtnStylesConst.STYLE_HEAVY_BLACK] = new UniversalStyle(HEAVY_STATES_BLACK_LINKAGE,DISABLE_FILL_BMD_LINKAGE,SLIM_TOGGLE_INDICATOR_LINKAGE,SLIM_TOGGLE_GLOW_LINKAGE,TF_SIZE_HEAVY,TF_COLOR,_loc6_,STATES_BASIC_SHADOW_FILTER);
         var _loc7_:Dictionary = createTextAlphaStates(1,1,1,1,1,0.6);
         this._styles[UniversalBtnStylesConst.STYLE_HEAVY_GREEN] = new UniversalStyle(HEAVY_STATES_GREEN_LINKAGE,DISABLE_FILL_BMD_LINKAGE,SLIM_TOGGLE_INDICATOR_LINKAGE,SLIM_TOGGLE_GLOW_LINKAGE,TF_SIZE_HEAVY,TF_COLOR,_loc7_,STATES_BASIC_SHADOW_FILTER);
         var _loc8_:Dictionary = createTextAlphaStates(1,1,1,1,1,0.6);
         this._styles[UniversalBtnStylesConst.STYLE_HEAVY_ORANGE] = new UniversalStyle(HEAVY_STATES_ORANGE_LINKAGE,DISABLE_FILL_BMD_LINKAGE,SLIM_TOGGLE_INDICATOR_LINKAGE,SLIM_TOGGLE_GLOW_LINKAGE,TF_SIZE_HEAVY,TF_COLOR,_loc8_,STATES_ORANGE_SHADOW_FILTER);
         var _loc9_:Dictionary = createTextAlphaStates(1,1,1,1,1,0.6);
         this._styles[UniversalBtnStylesConst.STYLE_HEAVY_LIME] = new UniversalStyle(HEAVY_STATES_LIME_LINKAGE,DISABLE_FILL_BMD_LINKAGE,SLIM_TOGGLE_INDICATOR_LINKAGE,SLIM_TOGGLE_GLOW_LINKAGE,TF_SIZE_HEAVY,TF_COLOR,_loc9_,STATES_BASIC_SHADOW_FILTER);
         var _loc10_:Dictionary = createTextAlphaStates(1,1,1,1,1,0.6);
         this._styles[UniversalBtnStylesConst.STYLE_HEAVY_NY_TRANSPARENT] = new UniversalStyle(HEAVY_STATES_NY_TRANSPARENT_LINKAGE,DISABLE_FILL_BMD_LINKAGE,SLIM_TOGGLE_INDICATOR_LINKAGE,SLIM_TOGGLE_GLOW_LINKAGE,TF_SIZE_NY_HEAVY,TF_COLOR_NY,_loc10_,STATES_BASIC_SHADOW_FILTER);
         var _loc11_:Dictionary = createTextAlphaStates(1,1,1,1,1,0.6);
         this._styles[UniversalBtnStylesConst.STYLE_SLIM_NY_TRANSPARENT] = new UniversalStyle(SLIM_STATES_NY_TRANSPARENT_LINKAGE,DISABLE_FILL_BMD_LINKAGE,SLIM_TOGGLE_INDICATOR_LINKAGE,SLIM_TOGGLE_GLOW_LINKAGE,TF_SIZE_SLIM,TF_COLOR_NY,_loc11_,STATES_BASIC_SHADOW_FILTER);
      }
      
      private static function createTextAlphaStates(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Dictionary
      {
         var _loc7_:Dictionary = new Dictionary();
         _loc7_[UP] = param1;
         _loc7_[OVER] = param2;
         _loc7_[DOWN] = param3;
         _loc7_[RELEASE] = param4;
         _loc7_[OUT] = param5;
         _loc7_[DISABLED] = param6;
         return _loc7_;
      }
      
      public final function dispose() : void
      {
         var _loc2_:* = null;
         this._disposed = true;
         var _loc1_:UniversalStyle = null;
         for(_loc2_ in this._styles)
         {
            _loc1_ = this._styles[_loc2_];
            _loc1_.dispose();
            delete this._styles[_loc2_];
         }
         _loc1_ = null;
         this._styles = null;
         this._classFactory = null;
      }
      
      public function setClassFactory(param1:IClassFactory) : void
      {
         this._classFactory = param1;
      }
      
      public function setStyle(param1:IUniversalBtn, param2:String) : void
      {
         if(param1.styleID == param2)
         {
            return;
         }
         var _loc3_:IUniversalStyle = this.getStyle(param2);
         var _loc4_:IUniversalBtnStyledDisplayObjects = this.getStyledDisplayObjects(_loc3_);
         param1.addEventListener(UniversalBtnEvent.CLEAR_STYLE,this.onUniversalBtnClearStyleHandler);
         param1.setStyle(param2,_loc4_,_loc3_.tfSize,_loc3_.tfColor,_loc3_.statesTextFieldColor,_loc3_.disableBitmapSrc,_loc3_.tfShadowFilter);
      }
      
      private function getStyle(param1:String) : IUniversalStyle
      {
         if(param1 in this._styles)
         {
            return this._styles[param1];
         }
         return null;
      }
      
      private function getStyledDisplayObjects(param1:IUniversalStyle) : IUniversalBtnStyledDisplayObjects
      {
         var _loc2_:IUniversalBtnStyledDisplayObjects = param1.getStyledDisplayObjects();
         if(_loc2_)
         {
            return _loc2_;
         }
         var _loc3_:MovieClip = this._classFactory.getComponent(param1.statesLinkage,MovieClip);
         _loc3_.name = OBJECT_NAME_SKIN;
         var _loc4_:Sprite = this._classFactory.getComponent(param1.toggleGlowLinkage,Sprite);
         _loc4_.name = OBJECT_NAME_TOGGLE_GLOW;
         var _loc5_:IUniversalBtnToggleIndicator = this._classFactory.getComponent(param1.toggleIndicatorLinkage,IUniversalBtnToggleIndicator);
         _loc5_.name = OBJECT_NAME_TOGGLE_INDICATOR;
         return new UniversalBtnStyledDisplayObjects(_loc3_,_loc4_,_loc5_);
      }
      
      private function onUniversalBtnClearStyleHandler(param1:UniversalBtnEvent) : void
      {
         var _loc2_:IUniversalBtn = IUniversalBtn(param1.target);
         _loc2_.removeEventListener(UniversalBtnEvent.CLEAR_STYLE,this.onUniversalBtnClearStyleHandler);
         var _loc3_:IUniversalStyle = this.getStyle(_loc2_.styleID);
         _loc3_.addStyledDisplayObjects(_loc2_.styledDisplayObjects);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
