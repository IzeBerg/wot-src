package net.wg.gui.lobby.vehiclePreview.infoPanel.crew
{
   import net.wg.gui.lobby.components.data.BaseTankmanVO;
   
   public class TankmanVO extends BaseTankmanVO
   {
       
      
      public var efficiencyLevel:int = -1;
      
      public var bonus:int = -1;
      
      public var isLessMastered:Boolean = false;
      
      public var availableSkillsCount:int = -1;
      
      public var selected:Boolean = false;
      
      public var recruit:Boolean = false;
      
      public var personalCase:Boolean = false;
      
      public var currentRole:TankmanRoleVO;
      
      public function TankmanVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.currentRole)
         {
            this.currentRole.dispose();
            this.currentRole = null;
         }
         super.onDispose();
      }
   }
}
