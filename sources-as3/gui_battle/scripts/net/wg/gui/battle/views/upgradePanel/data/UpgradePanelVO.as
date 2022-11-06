package net.wg.gui.battle.views.upgradePanel.data
{
   import net.wg.gui.battle.battleRoyale.views.configurator.data.ChoiceInfoPanelVO;
   
   public class UpgradePanelVO extends ChoiceInfoPanelVO
   {
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var isInitData:Boolean = false;
      
      public function UpgradePanelVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
