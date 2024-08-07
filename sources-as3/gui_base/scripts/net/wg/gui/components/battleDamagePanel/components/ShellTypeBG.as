package net.wg.gui.components.battleDamagePanel.components
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.DAMAGE_LOG_SHELL_BG_TYPES;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class ShellTypeBG extends Sprite implements IDisposable
   {
      
      private static const EMPTY_BG_POS_Y:uint = 7;
      
      private static const EMPTY_BG_WIDTH:uint = 14;
      
      private static const R_EDGE_ROTATION:uint = 180;
       
      
      private var _leftEdge:Shape;
      
      private var _rightEdge:Shape;
      
      private var _center:Shape;
      
      private var _emptyShellBG:Sprite;
      
      private var _compositeBGContainer:Sprite;
      
      private var _atlasMgr:IAtlasManager;
      
      private var _edgeWidth:int = 0;
      
      private var _currentState:String;
      
      private var _isEmpty:Boolean = false;
      
      private var _atlasName:String = "";
      
      private var _currentWidth:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function ShellTypeBG(param1:String)
      {
         this._leftEdge = new Shape();
         this._rightEdge = new Shape();
         this._center = new Shape();
         this._emptyShellBG = new Sprite();
         this._compositeBGContainer = new Sprite();
         this._atlasMgr = App.atlasMgr;
         this._currentState = DAMAGE_LOG_SHELL_BG_TYPES.DEFAULT;
         super();
         this._atlasName = param1;
         this._compositeBGContainer.addChild(this._leftEdge);
         this._compositeBGContainer.addChild(this._rightEdge);
         this._compositeBGContainer.addChild(this._center);
         addChild(this._compositeBGContainer);
         addChild(this._emptyShellBG);
         this._emptyShellBG.y = EMPTY_BG_POS_Y;
         this._compositeBGContainer.visible = !this._isEmpty;
         this._emptyShellBG.visible = this._isEmpty;
         this._rightEdge.rotation = R_EDGE_ROTATION;
         this._atlasMgr.drawGraphics(this._atlasName,BATTLEATLAS.WHITE_EDGE,this._leftEdge.graphics);
         this._atlasMgr.drawGraphics(this._atlasName,BATTLEATLAS.WHITE_CENTER,this._center.graphics);
         this._atlasMgr.drawGraphics(this._atlasName,BATTLEATLAS.WHITE_EDGE,this._rightEdge.graphics);
         this._edgeWidth = this._leftEdge.width;
         this._center.x = this._edgeWidth;
         this._rightEdge.y = this._rightEdge.height >> 0;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._atlasMgr = null;
         this._compositeBGContainer = null;
         this._emptyShellBG = null;
         this._leftEdge = null;
         this._rightEdge = null;
         this._center = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setData(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1 == Values.EMPTY_STR)
         {
            this._emptyShellBG.visible = this._compositeBGContainer.visible = false;
            return;
         }
         var _loc2_:Boolean = param1 == DAMAGE_LOG_SHELL_BG_TYPES.EMPTY;
         if(_loc2_ != this._isEmpty)
         {
            this._isEmpty = _loc2_;
            this._compositeBGContainer.visible = !_loc2_;
            this._emptyShellBG.visible = _loc2_;
         }
         if(_loc2_)
         {
            this._atlasMgr.drawGraphics(this._atlasName,BATTLEATLAS.EMPTY_SHELL_BG,this._emptyShellBG.graphics);
         }
         else if(this._currentState != param1)
         {
            this._currentState = param1;
            switch(param1)
            {
               case DAMAGE_LOG_SHELL_BG_TYPES.GOLD:
                  _loc3_ = BATTLEATLAS.GOLD_EDGE;
                  _loc4_ = BATTLEATLAS.GOLD_CENTER;
                  break;
               case DAMAGE_LOG_SHELL_BG_TYPES.DEFAULT:
                  _loc3_ = BATTLEATLAS.WHITE_EDGE;
                  _loc4_ = BATTLEATLAS.WHITE_CENTER;
                  break;
               case DAMAGE_LOG_SHELL_BG_TYPES.SPG:
                  _loc3_ = BATTLEATLAS.WHITE_BLACK_EDGE;
                  _loc4_ = BATTLEATLAS.WHITE_BLACK_CENTER;
                  break;
               case DAMAGE_LOG_SHELL_BG_TYPES.SPG_HE_NO_STUN:
                  _loc3_ = BATTLEATLAS.GOLD_BLACK_EDGE;
                  _loc4_ = BATTLEATLAS.GOLD_BLACK_CENTER;
            }
            this._atlasMgr.drawGraphics(this._atlasName,_loc3_,this._leftEdge.graphics);
            this._atlasMgr.drawGraphics(this._atlasName,_loc4_,this._center.graphics);
            this._atlasMgr.drawGraphics(this._atlasName,_loc3_,this._rightEdge.graphics);
         }
      }
      
      public function updateWidth(param1:int) : void
      {
         var _loc2_:int = 0;
         if(this._currentWidth != param1)
         {
            this._currentWidth = param1;
            _loc2_ = param1 - (this._edgeWidth << 1);
            this._center.width = _loc2_;
            this._rightEdge.x = (this._edgeWidth << 1) + _loc2_;
            this._emptyShellBG.x = param1 - EMPTY_BG_WIDTH >> 1;
         }
      }
   }
}
