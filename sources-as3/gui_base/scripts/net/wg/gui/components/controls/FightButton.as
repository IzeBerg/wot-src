package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class FightButton extends SoundButton
   {
       
      
      public var highlightHolder:MovieClip = null;
      
      private var _highlight:MovieClip = null;
      
      private var _linkage:String = "";
      
      public function FightButton()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = _newFrame;
         super.draw();
         if(this._highlight && StringUtils.isNotEmpty(_loc1_) && isInvalid(InvalidationType.STATE))
         {
            if(_baseDisposed)
            {
               return;
            }
            this._highlight.gotoAndPlay(_loc1_);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._highlight)
         {
            this.highlightHolder.removeChild(this._highlight);
         }
         this._highlight = null;
         this.highlightHolder = null;
         super.onDispose();
      }
      
      public function getRectangle() : Rectangle
      {
         var _loc1_:Rectangle = new Rectangle();
         _loc1_.x = this.x + hitMc.x;
         _loc1_.width = hitMc.width;
         return _loc1_;
      }
      
      public function setHighlight(param1:String) : void
      {
         if(this._linkage == param1)
         {
            return;
         }
         this._linkage = param1;
         if(StringUtils.isNotEmpty(param1))
         {
            if(this._highlight)
            {
               this.highlightHolder.removeChild(this._highlight);
            }
            this._linkage = param1;
            this._highlight = App.utils.classFactory.getComponent(this._linkage,MovieClip);
            this.highlightHolder.addChild(this._highlight);
            this._highlight.gotoAndPlay(currentFrame);
         }
         else
         {
            this.highlightHolder.removeChild(this._highlight);
            this._highlight = null;
         }
      }
   }
}
