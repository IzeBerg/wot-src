package net.wg.gui.lobby.sessionStats.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.tooltips.helpers.TankTypeIco;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SessionStatsTankSmallName extends Sprite implements IDisposable
   {
      
      private static const LEFT_TF_OFFSET:int = 16;
      
      private static const RIGHT_TF_OFFSET:int = -12;
      
      private static const TF_ELITE_EXTRA_OFFSET:int = 10;
      
      private static const LAYOUT_START_X:int = 3;
       
      
      public var tankTier:TextField = null;
      
      public var tankNameSmall:TextField = null;
      
      public var tankIcon:TankTypeIco = null;
      
      private var _isElite:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function SessionStatsTankSmallName()
      {
         super();
         this.tankTier.autoSize = TextFieldAutoSize.LEFT;
         this.tankNameSmall.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      public function setData(param1:String, param2:String, param3:String, param4:Boolean) : void
      {
         this._isElite = param4;
         this.tankIcon.type = param1;
         this.tankTier.htmlText = param2;
         this.tankNameSmall.htmlText = param3;
      }
      
      public function validateSize() : void
      {
         this.tankIcon.validateNow();
         var _loc1_:int = LEFT_TF_OFFSET;
         var _loc2_:int = RIGHT_TF_OFFSET;
         if(this._isElite)
         {
            _loc1_ += TF_ELITE_EXTRA_OFFSET;
            _loc2_ += TF_ELITE_EXTRA_OFFSET;
         }
         var _loc3_:int = LAYOUT_START_X;
         this.tankTier.x = _loc3_;
         _loc3_ += this.tankTier.width + _loc1_;
         this.tankIcon.x = _loc3_;
         _loc3_ += _loc2_ + this.tankIcon.width;
         this.tankNameSmall.x = _loc3_;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.tankIcon.dispose();
         this.tankIcon = null;
         this.tankNameSmall = null;
         this.tankTier = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
