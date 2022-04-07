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
      
      private var _disposed:Boolean = false;
      
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
         this._disposed = true;
         this.commander = null;
         this.techParameters = null;
         this.bottomPanel = null;
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this.bottomPanel.y = param2;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
