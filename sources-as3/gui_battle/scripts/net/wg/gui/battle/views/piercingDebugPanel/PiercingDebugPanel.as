package net.wg.gui.battle.views.piercingDebugPanel
{
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.views.piercingDebugPanel.data.DebugPanelVO;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.infrastructure.base.meta.IPiercingDebugPanelMeta;
   import net.wg.infrastructure.base.meta.impl.PiercingDebugPanelMeta;
   import scaleform.clik.data.DataProvider;
   
   public class PiercingDebugPanel extends PiercingDebugPanelMeta implements IPiercingDebugPanelMeta
   {
      
      private static const PADDING_BOTTOM:int = 265;
       
      
      public var shellTypeTF:TextField = null;
      
      public var piercingPowerTF:TextField = null;
      
      public var dispersionTF:TextField = null;
      
      public var shellTypeValueTF:TextField = null;
      
      public var piercingPowerValueTF:TextField = null;
      
      public var dispersionValueTF:TextField = null;
      
      public var vehiclePartTF:TextField = null;
      
      public var baseArmorTF:TextField = null;
      
      public var angleTF:TextField = null;
      
      public var penetrationArmorTF:TextField = null;
      
      public var piercingPowerLeftTF:TextField = null;
      
      public var piercingPercentTF:TextField = null;
      
      public var minTF:TextField = null;
      
      public var maxTF:TextField = null;
      
      public var minPPTF:TextField = null;
      
      public var maxPPTF:TextField = null;
      
      public var piercingList:ScrollingListEx = null;
      
      public function PiercingDebugPanel()
      {
         super();
         this.piercingList.itemRendererName = Linkages.PIERCING_DEBUG_RENDERER;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehiclePartTF.text = DEVELOPMENT.PIERCINGDEBUGPANEL_TABLE_VEHPART;
         this.baseArmorTF.text = DEVELOPMENT.PIERCINGDEBUGPANEL_TABLE_ARMOR;
         this.angleTF.text = DEVELOPMENT.PIERCINGDEBUGPANEL_TABLE_ANGLE;
         this.penetrationArmorTF.text = DEVELOPMENT.PIERCINGDEBUGPANEL_TABLE_PENETRATIONARMOR;
         this.piercingPowerLeftTF.text = DEVELOPMENT.PIERCINGDEBUGPANEL_TABLE_PIERCINGPOWERLEFT;
         this.piercingPercentTF.text = DEVELOPMENT.PIERCINGDEBUGPANEL_TABLE_PIERCINGPERCENT;
         this.shellTypeTF.text = DEVELOPMENT.PIERCINGDEBUGPANEL_HEADER_SHELLTYPE;
         this.piercingPowerTF.text = DEVELOPMENT.PIERCINGDEBUGPANEL_HEADER_PIERCINGPOWER;
         this.dispersionTF.text = DEVELOPMENT.PIERCINGDEBUGPANEL_HEADER_DISPERSION;
         this.minTF.text = "0";
         this.maxTF.text = MENU.INFINITYSYMBOL;
      }
      
      override protected function onDispose() : void
      {
         this.shellTypeTF = null;
         this.piercingPowerTF = null;
         this.dispersionTF = null;
         this.shellTypeValueTF = null;
         this.piercingPowerValueTF = null;
         this.dispersionValueTF = null;
         this.vehiclePartTF = null;
         this.baseArmorTF = null;
         this.angleTF = null;
         this.penetrationArmorTF = null;
         this.piercingPowerLeftTF = null;
         this.piercingPercentTF = null;
         this.minTF = null;
         this.maxTF = null;
         this.minPPTF = null;
         this.maxPPTF = null;
         this.piercingList.dispose();
         this.piercingList = null;
         super.onDispose();
      }
      
      override protected function setData(param1:DebugPanelVO) : void
      {
         this.shellTypeValueTF.text = param1.shellType;
         this.piercingPowerValueTF.text = param1.piercingPower;
         this.dispersionValueTF.text = param1.dispersion;
         this.minPPTF.text = param1.minPPValue;
         this.maxPPTF.text = param1.maxPPValue;
         this.piercingList.dataProvider = new DataProvider(App.utils.data.vectorToArray(param1.piercingItems));
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         x = param1 - width >> 1;
         y = param2 - PADDING_BOTTOM >> 0;
      }
   }
}
