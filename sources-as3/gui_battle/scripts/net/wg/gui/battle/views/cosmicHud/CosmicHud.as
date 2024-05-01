package net.wg.gui.battle.views.cosmicHud
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   
   public class CosmicHud extends GFInjectComponent implements IDisplayableComponent
   {
       
      
      public function CosmicHud()
      {
         super();
         setManageSize(true);
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         x = y = 0;
         setSize(param1,param2);
         invalidateSize();
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
         visible = param1;
      }
      
      public function isCompVisible() : Boolean
      {
         return visible;
      }
   }
}
