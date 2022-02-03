package net.wg.gui.components.battleDamagePanel.components
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class DefaultSummaryImages extends Sprite implements IDisposable
   {
      
      private static const IMG_X_POSITION:int = 6;
       
      
      private var _bg:Sprite = null;
      
      private var _img:Sprite = null;
      
      private var _atlasName:String = "";
      
      private var _atlasMgr:IAtlasManager = null;
      
      private var _disposed:Boolean = false;
      
      public function DefaultSummaryImages()
      {
         super();
         this._atlasMgr = App.atlasMgr;
         this._bg = new Sprite();
         this._bg.name = "bg";
         this.addChild(this._bg);
         this._img = new Sprite();
         this._img.name = "img";
         this.addChild(this._img);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._atlasMgr = null;
         this._bg = null;
         this._img = null;
      }
      
      public function init(param1:String) : void
      {
         this._atlasName = param1;
      }
      
      public function loadImages(param1:String, param2:String) : void
      {
         this._atlasMgr.drawGraphics(this._atlasName,param1,this._bg.graphics);
         this._atlasMgr.drawGraphics(this._atlasName,param2,this._img.graphics);
         this._bg.x = 0;
         this._img.x = IMG_X_POSITION;
         this._img.y = this._bg.height - this._img.height >> 1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
