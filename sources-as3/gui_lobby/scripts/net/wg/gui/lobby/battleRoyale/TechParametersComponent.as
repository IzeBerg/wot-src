package net.wg.gui.lobby.battleRoyale
{
   import flash.display.DisplayObject;
   import net.wg.gui.components.containers.GFWrapper;
   import net.wg.infrastructure.base.meta.IBattleRoyaleTechParametersComponent;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleTechParametersComponent;
   
   public class TechParametersComponent extends BattleRoyaleTechParametersComponent implements IBattleRoyaleTechParametersComponent
   {
      
      private static const TECH_PARAMETERS_LEFT_MASK_OFFSET:int = 50;
      
      private static const TECH_PARAMETERS_WIDTH:int = 349;
      
      private static const TECH_PARAMETERS_HEIGHT:int = 500;
       
      
      public function TechParametersComponent()
      {
         super();
         width = TECH_PARAMETERS_WIDTH;
         height = TECH_PARAMETERS_HEIGHT;
      }
      
      public function as_updateHeight(param1:Number) : void
      {
         if(wrapper && param1)
         {
            this.hitObject.x = wrapper.hitArea.x = TECH_PARAMETERS_LEFT_MASK_OFFSET;
            this.hitObject.width = wrapper.hitArea.width = width - TECH_PARAMETERS_LEFT_MASK_OFFSET;
            this.hitObject.height = wrapper.hitArea.height = param1;
         }
      }
      
      public function get hitObject() : DisplayObject
      {
         return Boolean(wrapper) ? GFWrapper(wrapper).inputFixTF : null;
      }
   }
}
