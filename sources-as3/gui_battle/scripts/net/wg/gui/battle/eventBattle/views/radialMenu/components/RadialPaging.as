package net.wg.gui.battle.eventBattle.views.radialMenu.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RadialPaging extends Sprite implements IDisposable
   {
       
      
      public var nextPageTF:TextField = null;
      
      public var pageDot:Sprite = null;
      
      public var page1:Sprite = null;
      
      public var page2:Sprite = null;
      
      private var _pages:Vector.<Sprite> = null;
      
      private var _disposed:Boolean = false;
      
      public function RadialPaging()
      {
         super();
         this._pages = new <Sprite>[this.page1,this.page2];
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._pages.splice(0,this._pages.length);
         this._pages = null;
         this.nextPageTF = null;
         this.pageDot = null;
         this.page1 = null;
         this.page2 = null;
      }
      
      public function setCurrentPage(param1:int) : void
      {
         this.pageDot.x = this._pages[param1].x;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
