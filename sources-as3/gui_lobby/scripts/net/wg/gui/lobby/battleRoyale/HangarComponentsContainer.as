package net.wg.gui.lobby.battleRoyale
{
   import flash.display.Sprite;
   import net.wg.gui.components.UnboundComponent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HangarComponentsContainer extends Sprite implements IDisposable
   {
       
      
      public var commander:UnboundComponent = null;
      
      public var techParameters:UnboundComponent = null;
      
      public var bottomPanel:UnboundComponent = null;
      
      public function HangarComponentsContainer()
      {
         super();
         this.commander = new UnboundComponent();
         this.techParameters = new UnboundComponent();
         this.bottomPanel = new UnboundComponent();
         addChild(this.commander);
         addChild(this.techParameters);
         addChild(this.bottomPanel);
      }
      
      public function dispose() : void
      {
         this.commander = null;
         this.techParameters = null;
         this.bottomPanel = null;
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this.bottomPanel.y = param2;
      }
   }
}
