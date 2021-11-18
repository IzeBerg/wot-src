package net.wg.gui.lobby.modulesPanel.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.data.TabDataVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IUtils;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.data.DataProvider;
   
   public class FittingSelectPopoverVO extends DAAPIDataClass
   {
      
      private static const RENDERER_DATA_CLASS_FIELD_NAME:String = "rendererDataClass";
      
      private static const FIELD_TAB_DATA:String = "tabData";
      
      private static const FIELD_AVAILABLE_DEVICES:String = "availableDevices";
      
      private static const FIELD_LIST_OVERLAY:String = "listOverlay";
       
      
      public var title:String = "";
      
      public var availableDevices:DataProvider = null;
      
      public var selectedIndex:int = -1;
      
      public var scrollToIndex:int = -1;
      
      public var width:int = -1;
      
      public var rendererName:String = "";
      
      public var preferredLayout:int = -1;
      
      public var tabData:DataProvider = null;
      
      public var selectedTab:int;
      
      public var rearmCheckboxVisible:Boolean = false;
      
      public var rearmCheckboxValue:Boolean = false;
      
      public var battleAbilitiesButtonVisible:Boolean = false;
      
      public var listOverlay:ListOverlayVO = null;
      
      public var tabCounters:Array = null;
      
      private var _rendererDataClass:Class = null;
      
      private var _rawAvailableDevices:Array;
      
      private var _utils:IUtils;
      
      public function FittingSelectPopoverVO(param1:Object)
      {
         this._utils = App.utils;
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         if(param1 == RENDERER_DATA_CLASS_FIELD_NAME)
         {
            _loc3_ = param2 as String;
            this._utils.asserter.assert(StringUtils.isNotEmpty(_loc3_),param1 + Errors.CANT_EMPTY);
            this._rendererDataClass = this._utils.classFactory.getClass(_loc3_);
            if(this._rawAvailableDevices)
            {
               this.fillAvailableDevices(this._rawAvailableDevices);
            }
            return false;
         }
         if(param1 == FIELD_TAB_DATA)
         {
            this.tabData = new DataProvider();
            for each(_loc4_ in param2 as Array)
            {
               this.tabData.push(new TabDataVO(_loc4_));
            }
            return false;
         }
         if(param1 == FIELD_AVAILABLE_DEVICES)
         {
            if(this._rendererDataClass != null)
            {
               this.fillAvailableDevices(param2 as Array);
            }
            else
            {
               this._rawAvailableDevices = param2 as Array;
            }
            return false;
         }
         if(param1 == FIELD_LIST_OVERLAY && param2)
         {
            this.listOverlay = new ListOverlayVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.availableDevices != null)
         {
            for each(_loc1_ in this.availableDevices)
            {
               _loc1_.dispose();
            }
            this.availableDevices.cleanUp();
            this.availableDevices = null;
         }
         if(this.tabData)
         {
            for each(_loc1_ in this.tabData)
            {
               _loc1_.dispose();
            }
            this.tabData.cleanUp();
            this.tabData = null;
         }
         if(this.listOverlay)
         {
            this.listOverlay.dispose();
            this.listOverlay = null;
         }
         this._rendererDataClass = null;
         this._utils = null;
         super.onDispose();
      }
      
      private function fillAvailableDevices(param1:Array) : void
      {
         var _loc2_:Object = null;
         this.availableDevices = new DataProvider();
         for each(_loc2_ in param1 as Array)
         {
            this.availableDevices.push(new this._rendererDataClass(_loc2_));
         }
         if(this._rawAvailableDevices)
         {
            this._rawAvailableDevices.length = 0;
            this._rawAvailableDevices = null;
         }
      }
   }
}
