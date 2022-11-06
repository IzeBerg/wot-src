package net.wg.gui.lobby.personalMissions
{
   import net.wg.gui.lobby.personalMissions.components.OperationRenderer;
   import net.wg.gui.lobby.personalMissions.data.OperationVO;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class CampaignOperationsContainer extends UIComponentEx
   {
       
      
      public var operation0:OperationRenderer;
      
      public var operation1:OperationRenderer;
      
      public var operation2:OperationRenderer;
      
      public var operation3:OperationRenderer;
      
      public function CampaignOperationsContainer()
      {
         super();
         this.operation3.setArrowVisible(false);
      }
      
      override protected function onDispose() : void
      {
         this.operation0.dispose();
         this.operation0 = null;
         this.operation1.dispose();
         this.operation1 = null;
         this.operation2.dispose();
         this.operation2 = null;
         this.operation3.dispose();
         this.operation3 = null;
         super.onDispose();
      }
      
      public function setData(param1:Vector.<OperationVO>) : void
      {
         this.operation0.setData(param1[0]);
         this.operation1.setData(param1[1]);
         this.operation2.setData(param1[2]);
         this.operation3.setData(param1[3]);
      }
   }
}
