package net.wg.infrastructure.managers.utils.impl
{
   import flash.geom.Point;
   import net.wg.data.ImageUrlProperties;
   import net.wg.data.StrCaseProperties;
   import net.wg.infrastructure.base.meta.impl.UtilsManagerMeta;
   import net.wg.infrastructure.interfaces.IImageUrlProperties;
   import net.wg.infrastructure.interfaces.IStrCaseProperties;
   import net.wg.infrastructure.interfaces.entity.ISerializable;
   import net.wg.infrastructure.interfaces.pool.IPoolManager;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.infrastructure.managers.IElementBlurAdapter;
   import net.wg.utils.IAnimBuilder;
   import net.wg.utils.IAssertable;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.ICommons;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.IDataUtils;
   import net.wg.utils.IDateTime;
   import net.wg.utils.IFocusHandler;
   import net.wg.utils.IIME;
   import net.wg.utils.IIcons;
   import net.wg.utils.ILocale;
   import net.wg.utils.INations;
   import net.wg.utils.IPopUpManager;
   import net.wg.utils.IScheduler;
   import net.wg.utils.IStyleSheetManager;
   import net.wg.utils.ITweenAnimator;
   import net.wg.utils.IUniversalBtnStyles;
   import net.wg.utils.IUtils;
   import net.wg.utils.IVOManager;
   import net.wg.utils.IViewRestrictions;
   import net.wg.utils.helpLayout.IHelpLayout;
   
   public class Utils extends UtilsManagerMeta implements IUtils
   {
       
      
      private var _asserter:IAssertable = null;
      
      private var _scheduler:IScheduler = null;
      
      private var _locale:ILocale = null;
      
      private var _JSON:ISerializable = null;
      
      private var _helpLayout:IHelpLayout = null;
      
      private var _classFactory:IClassFactory = null;
      
      private var _popupManager:IPopUpManager = null;
      
      private var _commons:ICommons = null;
      
      private var _nations:INations = null;
      
      private var _focusHandler:IFocusHandler = null;
      
      private var _ime:IIME = null;
      
      private var _voManager:IVOManager = null;
      
      private var _icons:IIcons = null;
      
      private var _styleSheetManager:IStyleSheetManager = null;
      
      private var _tweenAnimator:ITweenAnimator = null;
      
      private var _animBuilder:IAnimBuilder = null;
      
      private var _dateTime:IDateTime = null;
      
      private var _poolManager:IPoolManager = null;
      
      private var _dataUtils:IDataUtils;
      
      private var _counterManager:ICounterManager;
      
      private var _viewRestrinctions:IViewRestrictions = null;
      
      private var _universalBtnStyles:IUniversalBtnStyles = null;
      
      private var _atlasManager:IAtlasManager = null;
      
      private var _blurAdapter:IElementBlurAdapter = null;
      
      public function Utils(param1:IAssertable, param2:IScheduler, param3:ILocale, param4:ISerializable, param5:IHelpLayout, param6:IClassFactory, param7:IPopUpManager, param8:ICommons, param9:IFocusHandler, param10:IIME, param11:IVOManager, param12:IIcons, param13:IStyleSheetManager, param14:ITweenAnimator, param15:IAnimBuilder, param16:IDateTime, param17:IPoolManager, param18:IDataUtils, param19:ICounterManager, param20:IViewRestrictions, param21:IUniversalBtnStyles, param22:IAtlasManager, param23:IElementBlurAdapter)
      {
         super();
         this._asserter = param1;
         this._scheduler = param2;
         this._locale = param3;
         this._JSON = param4;
         this._helpLayout = param5;
         this._classFactory = param6;
         this._popupManager = param7;
         this._commons = param8;
         this._focusHandler = param9;
         this._ime = param10;
         this._voManager = param11;
         this._icons = param12;
         this._styleSheetManager = param13;
         this._tweenAnimator = param14;
         this._animBuilder = param15;
         this._dateTime = param16;
         this._poolManager = param17;
         this._dataUtils = param18;
         this._counterManager = param19;
         this._viewRestrinctions = param20;
         this._universalBtnStyles = param21;
         this._atlasManager = param22;
         this._blurAdapter = param23;
      }
      
      override protected function onDispose() : void
      {
         if(this._blurAdapter != null)
         {
            this._blurAdapter.dispose();
            this._blurAdapter = null;
         }
         if(this._scheduler != null)
         {
            this._scheduler.dispose();
            this._scheduler = null;
         }
         if(this._helpLayout != null)
         {
            this._helpLayout.dispose();
            this._helpLayout = null;
         }
         if(this._counterManager != null)
         {
            this._counterManager.dispose();
            this._counterManager = null;
         }
         if(this._focusHandler != null)
         {
            this._focusHandler.dispose();
            this._focusHandler = null;
         }
         if(this._universalBtnStyles != null)
         {
            this._universalBtnStyles.dispose();
            this._universalBtnStyles = null;
         }
         if(this._atlasManager != null)
         {
            this._atlasManager.dispose();
            this._atlasManager = null;
         }
         if(this._classFactory != null)
         {
            this._classFactory.dispose();
            this._classFactory = null;
         }
         if(this._ime != null)
         {
            this._ime.dispose();
            this._ime = null;
         }
         if(this._voManager != null)
         {
            this._voManager.dispose();
            this._voManager = null;
         }
         if(this._tweenAnimator != null)
         {
            this._tweenAnimator.dispose();
            this._tweenAnimator = null;
         }
         if(this._poolManager != null)
         {
            this._poolManager.dispose();
            this._poolManager = null;
         }
         if(this._viewRestrinctions != null)
         {
            this._viewRestrinctions.dispose();
            this._viewRestrinctions = null;
         }
         this._animBuilder = null;
         this._dateTime = null;
         this._icons = null;
         this._styleSheetManager = null;
         this._popupManager = null;
         this._nations = null;
         this._asserter = null;
         this._locale = null;
         this._JSON = null;
         this._dataUtils = null;
         this._commons = null;
         super.onDispose();
      }
      
      public function getImageUrlProperties(param1:String, param2:int, param3:int, param4:int = -4, param5:int = 0) : IImageUrlProperties
      {
         return new ImageUrlProperties(param1,param2,param3,param4,param5);
      }
      
      public function getStrCaseProperties() : IStrCaseProperties
      {
         return new StrCaseProperties();
      }
      
      public function getTransformedUBCoordinate(param1:Function, param2:Number, param3:Number) : Object
      {
         var _loc4_:Object = null;
         var _loc5_:Point = null;
         if(param1 != null)
         {
            _loc5_ = param1(new Point(param2,param3));
            _loc4_ = {
               "x":_loc5_.x,
               "y":_loc5_.y
            };
         }
         else
         {
            _loc4_ = {
               "x":param2,
               "y":param3
            };
         }
         return _loc4_;
      }
      
      public function setNations(param1:INations) : void
      {
         this._nations = param1;
      }
      
      public function toUpperOrLowerCase(param1:String, param2:Boolean, param3:IStrCaseProperties = null) : String
      {
         return changeStringCasingS(param1,param2,param3);
      }
      
      public function get asserter() : IAssertable
      {
         return this._asserter;
      }
      
      public function get scheduler() : IScheduler
      {
         return this._scheduler;
      }
      
      public function get locale() : ILocale
      {
         return this._locale;
      }
      
      public function get JSON() : ISerializable
      {
         return this._JSON;
      }
      
      public function get helpLayout() : IHelpLayout
      {
         return this._helpLayout;
      }
      
      public function get classFactory() : IClassFactory
      {
         return this._classFactory;
      }
      
      public function get popupMgr() : IPopUpManager
      {
         return this._popupManager;
      }
      
      public function get commons() : ICommons
      {
         return this._commons;
      }
      
      public function get nations() : INations
      {
         return this._nations;
      }
      
      public function get focusHandler() : IFocusHandler
      {
         return this._focusHandler;
      }
      
      public function get IME() : IIME
      {
         return this._ime;
      }
      
      public function get voMgr() : IVOManager
      {
         return this._voManager;
      }
      
      public function get icons() : IIcons
      {
         return this._icons;
      }
      
      public function get styleSheetManager() : IStyleSheetManager
      {
         return this._styleSheetManager;
      }
      
      public function get tweenAnimator() : ITweenAnimator
      {
         return this._tweenAnimator;
      }
      
      public function get animBuilder() : IAnimBuilder
      {
         return this._animBuilder;
      }
      
      public function get dateTime() : IDateTime
      {
         return this._dateTime;
      }
      
      public function get poolManager() : IPoolManager
      {
         return this._poolManager;
      }
      
      public function get data() : IDataUtils
      {
         return this._dataUtils;
      }
      
      public function get counterManager() : ICounterManager
      {
         return this._counterManager;
      }
      
      public function get viewRestrictions() : IViewRestrictions
      {
         return this._viewRestrinctions;
      }
      
      public function get universalBtnStyles() : IUniversalBtnStyles
      {
         return this._universalBtnStyles;
      }
      
      public function get atlasManager() : IAtlasManager
      {
         return this._atlasManager;
      }
      
      public function get blurAdapter() : IElementBlurAdapter
      {
         return this._blurAdapter;
      }
   }
}
