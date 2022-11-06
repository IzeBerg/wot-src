package net.wg.gui.lobby.aimSettings
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AimContourContent extends MovieClip implements IDisposable
   {
      
      private static const TYPE_CONTOUR_STANDART:String = "standart";
      
      private static const TYPE_CONTOUR_SIMPLIFIED:String = "simplified";
      
      private static const TYPE_COLOR_BLIND:String = "_colorblind";
       
      
      public var penetrableBlock:MovieClip = null;
      
      public var impenetrableBlock:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      private var _contourType:int = -1;
      
      private var _penetrationType:int = -1;
      
      private var _impenetrableType:int = -1;
      
      private var _isColorBlind:Boolean = false;
      
      public function AimContourContent()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.penetrableBlock = null;
         this.impenetrableBlock = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function updateData(param1:int, param2:int, param3:int) : void
      {
         if(this._contourType != param1 || this._penetrationType != param2 || this._impenetrableType != param3)
         {
            this._contourType = param1;
            this._penetrationType = param2;
            this._impenetrableType = param3;
            this.updateLayout();
         }
      }
      
      private function updateLayout() : void
      {
         var _loc1_:String = Boolean(this._contourType) ? TYPE_CONTOUR_SIMPLIFIED : TYPE_CONTOUR_STANDART;
         var _loc2_:String = !!this._isColorBlind ? TYPE_COLOR_BLIND : Values.EMPTY_STR;
         var _loc3_:String = _loc1_ + _loc2_;
         App.utils.asserter.assertFrameExists(_loc3_,this);
         this.gotoAndStop(_loc3_);
         this.penetrableBlock.gotoAndStop(this._penetrationType + 1);
         this.impenetrableBlock.gotoAndStop(this._impenetrableType + 1);
      }
      
      public function set isColorBlind(param1:Boolean) : void
      {
         if(this._isColorBlind != param1)
         {
            this._isColorBlind = param1;
            this.updateLayout();
         }
      }
   }
}
