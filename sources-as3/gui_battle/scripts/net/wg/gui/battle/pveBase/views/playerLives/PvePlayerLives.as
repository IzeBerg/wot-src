package net.wg.gui.battle.pveBase.views.playerLives
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.infrastructure.base.meta.IPvePlayerLivesMeta;
   import net.wg.infrastructure.base.meta.impl.PvePlayerLivesMeta;
   import net.wg.utils.IClassFactory;
   
   public class PvePlayerLives extends PvePlayerLivesMeta implements IPvePlayerLivesMeta
   {
      
      private static const LIVE_UI:String = "LiveUI";
      
      private static const RESPAWN_LIVE_LABEL:String = "Live";
      
      private static const RESPAWN_DEAD_LABEl:String = "Dead";
      
      private static const RESPAWN_LOCKED_LABEl:String = "Locked";
      
      private static const RESPAWN_UNLOCKED_LABEl:String = "Unlocked";
      
      private static const SPACING:int = 42;
       
      
      public var livesContainer:Sprite = null;
      
      public var back:Sprite = null;
      
      private var _lives:Vector.<MovieClip>;
      
      private var _classFactory:IClassFactory;
      
      private var _isEnabled:Boolean = false;
      
      public function PvePlayerLives()
      {
         this._lives = new Vector.<MovieClip>();
         this._classFactory = App.utils.classFactory;
         super();
         this.back.visible = false;
      }
      
      public function get isEnabled() : Boolean
      {
         return this._isEnabled;
      }
      
      public function as_setCountLives(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:int = param1 + param2 + param3;
         if(_loc5_ > 0)
         {
            this.back.visible = true;
            this._isEnabled = true;
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(_loc6_ == this._lives.length)
            {
               _loc4_ = this._classFactory.getComponent(LIVE_UI,Sprite);
               this.livesContainer.addChild(_loc4_);
               this._lives.push(_loc4_);
            }
            else
            {
               _loc4_ = this._lives[_loc6_];
               _loc4_.visible = true;
            }
            if(_loc6_ < param2)
            {
               if(_loc4_.currentFrameLabel != RESPAWN_DEAD_LABEl)
               {
                  _loc4_.gotoAndPlay(RESPAWN_DEAD_LABEl);
               }
            }
            else if(_loc6_ >= param2 + param1)
            {
               _loc4_.gotoAndStop(RESPAWN_LOCKED_LABEl);
            }
            else if(_loc4_.currentFrameLabel == RESPAWN_LOCKED_LABEl)
            {
               _loc4_.gotoAndPlay(RESPAWN_UNLOCKED_LABEl);
            }
            else
            {
               _loc4_.gotoAndStop(RESPAWN_LIVE_LABEL);
            }
            _loc4_.x = _loc6_ * SPACING;
            _loc6_++;
         }
         _loc5_ = this._lives.length;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = this._lives[_loc6_];
            _loc4_.visible = false;
            _loc6_++;
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:MovieClip = null;
         this._classFactory = null;
         for each(_loc1_ in this._lives)
         {
            _loc1_.stop();
            removeChild(_loc1_);
         }
         this._lives.splice(0,this._lives.length);
         this._lives = null;
         this.livesContainer = null;
         this.back = null;
         super.onDispose();
      }
   }
}
