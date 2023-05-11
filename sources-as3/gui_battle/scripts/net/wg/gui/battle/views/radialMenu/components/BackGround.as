package net.wg.gui.battle.views.radialMenu.components
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BackGround extends Sprite implements IDisposable
   {
       
      
      public var lback:Sprite = null;
      
      public var rback:Sprite = null;
      
      public var tback:Sprite = null;
      
      public var bback:Sprite = null;
      
      public var center:BattleAtlasSprite = null;
      
      private var _disposed:Boolean = false;
      
      public function BackGround()
      {
         super();
         this.center.imageName = BATTLEATLAS.RADIAL_MENU_HOLE;
      }
      
      public function setBackgroundAlpha(param1:Number) : void
      {
         this.lback.alpha = this.rback.alpha = this.tback.alpha = this.bback.alpha = param1;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this.tback.width = this.bback.width = this.rback.width = this.lback.width = param1;
         this.tback.height = this.bback.height = param2;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.lback = null;
         this.rback = null;
         this.tback = null;
         this.bback = null;
         this.center = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
