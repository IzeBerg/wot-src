package net.wg.gui.lobby.hangar.quests
{
   import flash.geom.Point;
   import scaleform.clik.motion.Tween;
   
   public class HeaderSecondaryWidgetInject extends HangarWidgetInject implements IHeaderSecondaryWidget
   {
       
      
      private var _pos:Point = null;
      
      private var _tween:Tween = null;
      
      private var _isInited:Boolean = false;
      
      public function HeaderSecondaryWidgetInject()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         this._pos = null;
         super.onDispose();
      }
      
      private function clearTween() : void
      {
         if(this._tween)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      public function animPosition(param1:int, param2:Object) : void
      {
         this.clearTween();
         if(this._pos == null)
         {
            return;
         }
         if(this._isInited)
         {
            this._tween = new Tween(param1,this,{
               "x":this._pos.x,
               "y":this._pos.y
            },param2);
         }
         else
         {
            this.x = this._pos.x;
            this.y = this._pos.y;
         }
      }
      
      public function get position() : Point
      {
         return this._pos;
      }
      
      public function set position(param1:Point) : void
      {
         this._isInited = Boolean(this._pos);
         this._pos = param1;
      }
   }
}
