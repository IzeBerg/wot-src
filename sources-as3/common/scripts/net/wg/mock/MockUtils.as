package net.wg.mock
{
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.IImageUrlProperties;
   import net.wg.infrastructure.interfaces.IStrCaseProperties;
   import net.wg.infrastructure.interfaces.entity.ISerializable;
   import net.wg.infrastructure.interfaces.pool.IPoolManager;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.infrastructure.managers.IElementBlurAdapter;
   import net.wg.mock.utils.MockAnimBuilder;
   import net.wg.mock.utils.MockAssertable;
   import net.wg.mock.utils.MockClassFactory;
   import net.wg.mock.utils.MockCommons;
   import net.wg.mock.utils.MockDateTime;
   import net.wg.mock.utils.MockFocusHandler;
   import net.wg.mock.utils.MockHelpLayout;
   import net.wg.mock.utils.MockIME;
   import net.wg.mock.utils.MockIcons;
   import net.wg.mock.utils.MockJSON;
   import net.wg.mock.utils.MockLocale;
   import net.wg.mock.utils.MockNations;
   import net.wg.mock.utils.MockPopUpManager;
   import net.wg.mock.utils.MockScheduler;
   import net.wg.mock.utils.MockStyleSheetManager;
   import net.wg.mock.utils.MockTweenAnimator;
   import net.wg.mock.utils.MockVOManager;
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
   
   public class MockUtils implements IUtils
   {
       
      
      private var _asserter:IAssertable;
      
      private var _scheduler:IScheduler;
      
      private var _locale:ILocale;
      
      private var _JSON:ISerializable;
      
      private var _helpLayout:IHelpLayout;
      
      private var _classFactory:IClassFactory;
      
      private var _popupMgr:IPopUpManager;
      
      private var _commons:ICommons;
      
      private var _nations:INations;
      
      private var _focusHandler:IFocusHandler;
      
      private var _IME:IIME;
      
      private var _voMgr:IVOManager;
      
      private var _icons:IIcons;
      
      private var _styleSheetManager:IStyleSheetManager;
      
      private var _tweenAnimator:ITweenAnimator;
      
      private var _animBuilder:IAnimBuilder;
      
      private var _dateTime:IDateTime;
      
      private var _dataUtils:IDataUtils;
      
      private var _counterManager:ICounterManager;
      
      private var _viewRestrictions:IViewRestrictions;
      
      public function MockUtils()
      {
         super();
         this._asserter = new MockAssertable();
         this._scheduler = new MockScheduler();
         this._locale = new MockLocale();
         this._JSON = new MockJSON();
         this._helpLayout = new MockHelpLayout();
         this._classFactory = new MockClassFactory();
         this._popupMgr = new MockPopUpManager();
         this._commons = new MockCommons();
         this._nations = new MockNations();
         this._focusHandler = new MockFocusHandler();
         this._IME = new MockIME();
         this._voMgr = new MockVOManager();
         this._icons = new MockIcons();
         this._styleSheetManager = new MockStyleSheetManager();
         this._tweenAnimator = new MockTweenAnimator();
         this._animBuilder = new MockAnimBuilder();
         this._dateTime = new MockDateTime();
         this._dataUtils = new MockDataUtils();
         this._counterManager = new MockCounterManager();
         this._viewRestrictions = new MockViewRestrictions();
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function changeStringCasingS(param1:String, param2:Boolean, param3:IStrCaseProperties) : String
      {
         return "";
      }
      
      public function mapScaleformToVirtualKeyS(param1:int) : int
      {
         return 0;
      }
      
      public function getCharFromVirtualKeyS(param1:int) : int
      {
         return 0;
      }
      
      public function dispose() : void
      {
      }
      
      public function getAbsoluteUrlS(param1:String) : String
      {
         return "";
      }
      
      public function getFirstDayOfWeekS() : int
      {
         return 0;
      }
      
      public function getGUINationsS() : Array
      {
         return null;
      }
      
      public function getHtmlIconTextS(param1:IImageUrlProperties) : String
      {
         return "";
      }
      
      public function getImageUrlProperties(param1:String, param2:int, param3:int, param4:int = -4, param5:int = 0) : IImageUrlProperties
      {
         return null;
      }
      
      public function getMonthsNamesS(param1:Boolean = true, param2:Boolean = false, param3:Boolean = false) : Array
      {
         return null;
      }
      
      public function getNationIndicesS() : Object
      {
         return null;
      }
      
      public function getNationNamesS() : Array
      {
         return null;
      }
      
      public function getStrCaseProperties() : IStrCaseProperties
      {
         return null;
      }
      
      public function getTransformedUBCoordinate(param1:Function, param2:Number, param3:Number) : Object
      {
         return {
            "x":0,
            "y":0
         };
      }
      
      public function getWeekDayNamesS(param1:Boolean = true, param2:Boolean = false, param3:Boolean = false) : Array
      {
         return null;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function intToStringWithPrefixPaternS(param1:int, param2:int, param3:String) : String
      {
         return "";
      }
      
      public function isTwelveHoursFormatS() : Boolean
      {
         return false;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
      }
      
      public function setNations(param1:INations) : void
      {
      }
      
      public function toUpperOrLowerCase(param1:String, param2:Boolean, param3:IStrCaseProperties = null) : String
      {
         return "";
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return false;
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
         return this._popupMgr;
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
         return this._IME;
      }
      
      public function get voMgr() : IVOManager
      {
         return this._voMgr;
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
         return null;
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
         return this._viewRestrictions;
      }
      
      public function get universalBtnStyles() : IUniversalBtnStyles
      {
         return null;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return false;
      }
      
      public function isDisposed() : Boolean
      {
         return false;
      }
      
      public function get atlasManager() : IAtlasManager
      {
         return null;
      }
      
      public function get blurAdapter() : IElementBlurAdapter
      {
         return null;
      }
   }
}
