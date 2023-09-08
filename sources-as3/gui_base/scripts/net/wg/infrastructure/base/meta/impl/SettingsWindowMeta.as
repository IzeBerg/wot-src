package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.settings.vo.SettingsNewCountersVo;
   import net.wg.gui.lobby.settings.vo.TabsDataVo;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class SettingsWindowMeta extends AbstractWindowView
   {
       
      
      public var applySettings:Function;
      
      public var autodetectQuality:Function;
      
      public var startVOIPTest:Function;
      
      public var updateCaptureDevices:Function;
      
      public var onSettingsChange:Function;
      
      public var altVoicesPreview:Function;
      
      public var altBulbPreview:Function;
      
      public var artyBulbPreview:Function;
      
      public var isSoundModeValid:Function;
      
      public var showWarningDialog:Function;
      
      public var onTabSelected:Function;
      
      public var onCounterTargetVisited:Function;
      
      public var autodetectAcousticType:Function;
      
      public var canSelectAcousticType:Function;
      
      public var openGammaWizard:Function;
      
      public var openColorSettings:Function;
      
      private var _dataProvider:DataProvider;
      
      private var _vectorSettingsNewCountersVo:Vector.<SettingsNewCountersVo>;
      
      private var _dataProviderTabsDataVo:DataProvider;
      
      private var _vectorint:Vector.<int>;
      
      public function SettingsWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:SettingsNewCountersVo = null;
         var _loc2_:TabsDataVo = null;
         if(this._dataProvider)
         {
            this._dataProvider.cleanUp();
            this._dataProvider = null;
         }
         if(this._vectorSettingsNewCountersVo)
         {
            for each(_loc1_ in this._vectorSettingsNewCountersVo)
            {
               _loc1_.dispose();
            }
            this._vectorSettingsNewCountersVo.splice(0,this._vectorSettingsNewCountersVo.length);
            this._vectorSettingsNewCountersVo = null;
         }
         if(this._dataProviderTabsDataVo)
         {
            for each(_loc2_ in this._dataProviderTabsDataVo)
            {
               _loc2_.dispose();
            }
            this._dataProviderTabsDataVo.cleanUp();
            this._dataProviderTabsDataVo = null;
         }
         if(this._vectorint)
         {
            this._vectorint.splice(0,this._vectorint.length);
            this._vectorint = null;
         }
         super.onDispose();
      }
      
      public function applySettingsS(param1:Object, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.applySettings,"applySettings" + Errors.CANT_NULL);
         this.applySettings(param1,param2);
      }
      
      public function autodetectQualityS() : Number
      {
         App.utils.asserter.assertNotNull(this.autodetectQuality,"autodetectQuality" + Errors.CANT_NULL);
         return this.autodetectQuality();
      }
      
      public function startVOIPTestS(param1:Boolean) : Boolean
      {
         App.utils.asserter.assertNotNull(this.startVOIPTest,"startVOIPTest" + Errors.CANT_NULL);
         return this.startVOIPTest(param1);
      }
      
      public function updateCaptureDevicesS() : void
      {
         App.utils.asserter.assertNotNull(this.updateCaptureDevices,"updateCaptureDevices" + Errors.CANT_NULL);
         this.updateCaptureDevices();
      }
      
      public function onSettingsChangeS(param1:String, param2:Object) : void
      {
         App.utils.asserter.assertNotNull(this.onSettingsChange,"onSettingsChange" + Errors.CANT_NULL);
         this.onSettingsChange(param1,param2);
      }
      
      public function altVoicesPreviewS() : void
      {
         App.utils.asserter.assertNotNull(this.altVoicesPreview,"altVoicesPreview" + Errors.CANT_NULL);
         this.altVoicesPreview();
      }
      
      public function altBulbPreviewS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.altBulbPreview,"altBulbPreview" + Errors.CANT_NULL);
         this.altBulbPreview(param1);
      }
      
      public function artyBulbPreviewS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.artyBulbPreview,"artyBulbPreview" + Errors.CANT_NULL);
         this.artyBulbPreview(param1);
      }
      
      public function isSoundModeValidS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.isSoundModeValid,"isSoundModeValid" + Errors.CANT_NULL);
         return this.isSoundModeValid();
      }
      
      public function showWarningDialogS(param1:String, param2:Object, param3:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.showWarningDialog,"showWarningDialog" + Errors.CANT_NULL);
         this.showWarningDialog(param1,param2,param3);
      }
      
      public function onTabSelectedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onTabSelected,"onTabSelected" + Errors.CANT_NULL);
         this.onTabSelected(param1);
      }
      
      public function onCounterTargetVisitedS(param1:String, param2:String, param3:Array) : void
      {
         App.utils.asserter.assertNotNull(this.onCounterTargetVisited,"onCounterTargetVisited" + Errors.CANT_NULL);
         this.onCounterTargetVisited(param1,param2,param3);
      }
      
      public function autodetectAcousticTypeS() : String
      {
         App.utils.asserter.assertNotNull(this.autodetectAcousticType,"autodetectAcousticType" + Errors.CANT_NULL);
         return this.autodetectAcousticType();
      }
      
      public function canSelectAcousticTypeS(param1:Number) : Boolean
      {
         App.utils.asserter.assertNotNull(this.canSelectAcousticType,"canSelectAcousticType" + Errors.CANT_NULL);
         return this.canSelectAcousticType(param1);
      }
      
      public function openGammaWizardS(param1:int, param2:int, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.openGammaWizard,"openGammaWizard" + Errors.CANT_NULL);
         this.openGammaWizard(param1,param2,param3);
      }
      
      public function openColorSettingsS() : void
      {
         App.utils.asserter.assertNotNull(this.openColorSettings,"openColorSettings" + Errors.CANT_NULL);
         this.openColorSettings();
      }
      
      public final function as_setCaptureDevices(param1:Number, param2:Array) : void
      {
         var _loc3_:DataProvider = this._dataProvider;
         this._dataProvider = new DataProvider(param2);
         this.setCaptureDevices(param1,this._dataProvider);
         if(_loc3_)
         {
            _loc3_.cleanUp();
         }
      }
      
      public final function as_setCountersData(param1:Array) : void
      {
         var _loc5_:SettingsNewCountersVo = null;
         var _loc2_:Vector.<SettingsNewCountersVo> = this._vectorSettingsNewCountersVo;
         this._vectorSettingsNewCountersVo = new Vector.<SettingsNewCountersVo>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorSettingsNewCountersVo[_loc4_] = new SettingsNewCountersVo(param1[_loc4_]);
            _loc4_++;
         }
         this.setCountersData(this._vectorSettingsNewCountersVo);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setFeedbackDataProvider(param1:Array) : void
      {
         var _loc5_:TabsDataVo = null;
         var _loc2_:DataProvider = this._dataProviderTabsDataVo;
         this._dataProviderTabsDataVo = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderTabsDataVo[_loc4_] = new TabsDataVo(param1[_loc4_]);
            _loc4_++;
         }
         this.setFeedbackDataProvider(this._dataProviderTabsDataVo);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      public final function as_setDisabledTabsOverlay(param1:Array, param2:String) : void
      {
         var _loc3_:Vector.<int> = this._vectorint;
         this._vectorint = new Vector.<int>(0);
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._vectorint[_loc5_] = param1[_loc5_];
            _loc5_++;
         }
         this.setDisabledTabsOverlay(this._vectorint,param2);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      protected function setCaptureDevices(param1:Number, param2:DataProvider) : void
      {
         var _loc3_:String = "as_setCaptureDevices" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function setCountersData(param1:Vector.<SettingsNewCountersVo>) : void
      {
         var _loc2_:String = "as_setCountersData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setFeedbackDataProvider(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setFeedbackDataProvider" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setDisabledTabsOverlay(param1:Vector.<int>, param2:String) : void
      {
         var _loc3_:String = "as_setDisabledTabsOverlay" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
