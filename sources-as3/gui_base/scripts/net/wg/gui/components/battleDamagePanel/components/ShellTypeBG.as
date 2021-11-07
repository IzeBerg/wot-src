package net.wg.gui.components.battleDamagePanel.components
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.DAMAGE_LOG_SHELL_BG_TYPES;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class ShellTypeBG extends Sprite implements IDisposable
   {
      
      private static const EMPTY_BG_POS_Y:Number = 6;
      
      private static const EMPTY_BG_WIDTH:Number = 14;
       
      
      private var _leftEdge:Shape = null;
      
      private var _rightEdge:Shape = null;
      
      private var _center:Shape = null;
      
      private var _emptyShellBG:Sprite = null;
      
      private var _compositeBGContainer:Sprite = null;
      
      private var _atlasMgr:IAtlasManager = null;
      
      private var _edgeWidth:Number = 0;
      
      private var _isGold:Boolean = false;
      
      private var _isEmpty:Boolean = false;
      
      private var _atlasName:String = "";
      
      private var _currentWidth:Number = 0;
      
      public function ShellTypeBG(param1:String)
      {
         super();
         this._atlasMgr = App.atlasMgr;
         this._atlasName = param1;
         this._compositeBGContainer = new Sprite();
         this._leftEdge = new Shape();
         this._rightEdge = new Shape();
         this._center = new Shape();
         this._emptyShellBG = new Sprite();
         this._compositeBGContainer.addChild(this._leftEdge);
         this._compositeBGContainer.addChild(this._rightEdge);
         this._compositeBGContainer.addChild(this._center);
         addChild(this._compositeBGContainer);
         addChild(this._emptyShellBG);
         this._emptyShellBG.y = EMPTY_BG_POS_Y;
         this._compositeBGContainer.visible = !this._isEmpty;
         this._emptyShellBG.visible = this._isEmpty;
         this._rightEdge.rotation = 180;
         this._atlasMgr.drawGraphics(this._atlasName,BATTLEATLAS.WHITE_EDGE,this._leftEdge.graphics);
         this._atlasMgr.drawGraphics(this._atlasName,BATTLEATLAS.WHITE_CENTER,this._center.graphics);
         this._atlasMgr.drawGraphics(this._atlasName,BATTLEATLAS.WHITE_EDGE,this._rightEdge.graphics);
         this._edgeWidth = this._leftEdge.width;
         this._center.x = this._edgeWidth;
         this._rightEdge.y = this._rightEdge.height;
      }
      
      public final function dispose() : void
      {
         this._atlasMgr = null;
         this._compositeBGContainer = null;
         this._emptyShellBG = null;
         this._leftEdge = null;
         this._rightEdge = null;
         this._center = null;
      }
      
      public function setData(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
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
         else
         {
            _loc5_ = param1 == DAMAGE_LOG_SHELL_BG_TYPES.GOLD;
            if(this._isGold != _loc5_)
            {
               this._isGold = _loc5_;
               if(_loc5_)
               {
                  _loc3_ = BATTLEATLAS.GOLD_EDGE;
                  _loc4_ = BATTLEATLAS.GOLD_CENTER;
               }
               else
               {
                  _loc3_ = BATTLEATLAS.WHITE_EDGE;
                  _loc4_ = BATTLEATLAS.WHITE_CENTER;
               }
               this._atlasMgr.drawGraphics(this._atlasName,_loc3_,this._leftEdge.graphics);
               this._atlasMgr.drawGraphics(this._atlasName,_loc4_,this._center.graphics);
               this._atlasMgr.drawGraphics(this._atlasName,_loc3_,this._rightEdge.graphics);
            }
         }
      }
      
      public function updateWidth(param1:Number) : void
      {
         var _loc2_:Number = NaN;
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
