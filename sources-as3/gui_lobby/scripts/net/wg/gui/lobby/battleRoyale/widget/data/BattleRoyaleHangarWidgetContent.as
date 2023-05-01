package net.wg.gui.lobby.battleRoyale.widget.data
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.components.containers.GFWrapper;
   import net.wg.infrastructure.base.meta.IBattleRoyaleHangarWidgetContentMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleHangarWidgetContentMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class BattleRoyaleHangarWidgetContent extends BattleRoyaleHangarWidgetContentMeta implements IBattleRoyaleHangarWidgetContentMeta
   {
      
      private static const BIG_SIZE:uint = 152;
      
      private static const SMALL_SIZE:uint = 132;
      
      private static const HIT_AREA_PADDING_X_BIG:int = 30;
      
      private static const HIT_AREA_PADDING_X_SMALL:int = 26;
      
      private static const HIT_AREA_PADDING_PROGRESS_FINISHED_X:int = 5;
       
      
      private var _hit:Sprite;
      
      private var _isSmall:Boolean = true;
      
      private var _isProgressionFinished:Boolean = false;
      
      public function BattleRoyaleHangarWidgetContent()
      {
         this._hit = new Sprite();
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = !!this._isSmall ? int(SMALL_SIZE) : int(BIG_SIZE);
            if(width != _loc1_)
            {
               width = height = _loc1_;
               dispatchEvent(new Event(Event.RESIZE));
               invalidateLayout();
            }
         }
         if(this.hitObject && isInvalid(InvalidationType.LAYOUT))
         {
            _loc2_ = !!this._isSmall ? int(HIT_AREA_PADDING_X_SMALL) : int(HIT_AREA_PADDING_X_BIG);
            if(this._isProgressionFinished)
            {
               _loc2_ = HIT_AREA_PADDING_PROGRESS_FINISHED_X;
            }
            this._hit.x = this.hitObject.x = _loc2_;
            this._hit.width = this.hitObject.width = width - _loc2_ * 2;
            this._hit.height = height;
            dispatchEvent(new Event(Event.ACTIVATE));
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this._hit;
         this._hit.graphics.beginFill(0,0);
         this._hit.graphics.drawRect(0,0,1,1);
         this._hit.buttonMode = this._hit.useHandCursor = true;
         addChildAt(this._hit,0);
      }
      
      override protected function onDispose() : void
      {
         this._hit = null;
         super.onDispose();
      }
      
      public function as_onWrapperInitialized() : void
      {
         invalidateLayout();
      }
      
      public function setIsProgressionFinished(param1:Boolean) : void
      {
         this._isProgressionFinished = param1;
         invalidateLayout();
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         this._isSmall = param1;
         invalidateSize();
      }
      
      public function get hitObject() : DisplayObject
      {
         return Boolean(wrapper) ? GFWrapper(wrapper).inputFixTF : null;
      }
   }
}
