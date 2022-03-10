package net.wg.utils
{
   import net.wg.infrastructure.base.meta.IUtilsManagerMeta;
   import net.wg.infrastructure.interfaces.IImageUrlProperties;
   import net.wg.infrastructure.interfaces.IStrCaseProperties;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.ISerializable;
   import net.wg.infrastructure.interfaces.pool.IPoolManager;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.infrastructure.managers.IElementBlurAdapter;
   import net.wg.utils.helpLayout.IHelpLayout;
   
   public interface IUtils extends IUtilsManagerMeta, IDisposable
   {
       
      
      function setNations(param1:INations) : void;
      
      function toUpperOrLowerCase(param1:String, param2:Boolean, param3:IStrCaseProperties = null) : String;
      
      function getStrCaseProperties() : IStrCaseProperties;
      
      function getImageUrlProperties(param1:String, param2:int, param3:int, param4:int = -4, param5:int = 0) : IImageUrlProperties;
      
      function getTransformedUBCoordinate(param1:Function, param2:Number, param3:Number) : Object;
      
      function get asserter() : IAssertable;
      
      function get scheduler() : IScheduler;
      
      function get locale() : ILocale;
      
      function get JSON() : ISerializable;
      
      function get helpLayout() : IHelpLayout;
      
      function get classFactory() : IClassFactory;
      
      function get popupMgr() : IPopUpManager;
      
      function get commons() : ICommons;
      
      function get data() : IDataUtils;
      
      function get nations() : INations;
      
      function get focusHandler() : IFocusHandler;
      
      function get IME() : IIME;
      
      function get voMgr() : IVOManager;
      
      function get icons() : IIcons;
      
      function get styleSheetManager() : IStyleSheetManager;
      
      function get tweenAnimator() : ITweenAnimator;
      
      function get animBuilder() : IAnimBuilder;
      
      function get dateTime() : IDateTime;
      
      function get poolManager() : IPoolManager;
      
      function get counterManager() : ICounterManager;
      
      function get viewRestrictions() : IViewRestrictions;
      
      function get universalBtnStyles() : IUniversalBtnStyles;
      
      function get atlasManager() : IAtlasManager;
      
      function get blurAdapter() : IElementBlurAdapter;
   }
}
