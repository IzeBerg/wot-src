package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.inscriptionController
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.gui.lobby.vehicleCustomization.data.inscriptionController.CustomizationInscriptionHintVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSoundEvent;
   import net.wg.infrastructure.base.meta.ICustomizationInscriptionControllerMeta;
   import net.wg.infrastructure.base.meta.impl.CustomizationInscriptionControllerMeta;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.managers.InputDelegate;
   import scaleform.clik.motion.Tween;
   
   public class CustomizationInscriptionController extends CustomizationInscriptionControllerMeta implements ICustomizationInscriptionControllerMeta
   {
      
      private static const SHAKE_DURATION:int = 300;
      
      private static const SHAKE_DISTANCE:int = 15;
      
      private static const SHAKE_FREQUENCY:int = 4;
       
      
      public var lines:MovieClip = null;
      
      public var hint:CustomizationInscriptionHint = null;
      
      private var _shakeTween:Tween;
      
      private var _image:MovieClip;
      
      public function CustomizationInscriptionController()
      {
         super();
      }
      
      private static function removeTween(param1:Tween) : void
      {
         if(param1)
         {
            param1.paused = true;
            param1.dispose();
         }
      }
      
      private static function checkKeyCode(param1:uint) : Boolean
      {
         return inRange(param1,Keyboard.NUMBER_0,Keyboard.NUMBER_9) || inRange(param1,Keyboard.NUMPAD_0,Keyboard.NUMPAD_9);
      }
      
      private static function inRange(param1:uint, param2:uint, param3:uint) : Boolean
      {
         return param1 >= param2 && param1 <= param3;
      }
      
      private static function getNumberByCode(param1:uint) : int
      {
         if(param1 > Keyboard.NUMBER_9)
         {
            return param1 - Keyboard.NUMPAD_0;
         }
         return param1 - Keyboard.NUMBER_0;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         visible = false;
         this.hint.visible = false;
         var _loc1_:Sprite = new Sprite();
         this.lines.hitArea = _loc1_;
         addChild(_loc1_);
         this.lines.mouseEnabled = this.lines.mouseChildren = false;
         this._image = this.lines.image;
         InputDelegate.getInstance().addEventListener(InputEvent.INPUT,this.onInputHandler,false,int.MAX_VALUE);
      }
      
      override protected function onDispose() : void
      {
         InputDelegate.getInstance().removeEventListener(InputEvent.INPUT,this.onInputHandler,false);
         this.hint.dispose();
         this.hint = null;
         this.lines = null;
         this._image = null;
         removeTween(this._shakeTween);
         this._shakeTween = null;
         super.onDispose();
      }
      
      override protected function showHint(param1:CustomizationInscriptionHintVO) : void
      {
         this.hint.showHint(param1);
      }
      
      public function as_show(param1:uint) : void
      {
         visible = true;
         App.utils.asserter.assert(param1 <= this._image.totalFrames,"Wrong lines length");
         this._image.gotoAndStop(param1);
         dispatchEvent(new CustomizationEvent(CustomizationEvent.SHOW_INSCRIPTION_CONTROLLER));
      }
      
      public function as_hide() : void
      {
         visible = false;
         dispatchEvent(new CustomizationEvent(CustomizationEvent.HIDE_INSCRIPTION_CONTROLLER));
      }
      
      override protected function invalidInscription(param1:CustomizationInscriptionHintVO) : void
      {
         this.hint.showAlert(param1);
         App.utils.scheduler.cancelTask(this.failureAlert);
         if(param1.delay > 0)
         {
            App.utils.scheduler.scheduleTask(this.failureAlert,param1.delay);
         }
         else
         {
            this.failureAlert();
         }
      }
      
      private function failureAlert() : void
      {
         dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,CUSTOMIZATION_ALIASES.SOUND_CUST_CHOICE_NUMBER_DENIED));
         this.playShake();
      }
      
      private function playShake() : void
      {
         removeTween(this._shakeTween);
         this._shakeTween = new Tween(SHAKE_DURATION,{"fraction":0},{"fraction":1},{
            "onChange":this.onShakeUpdate,
            "onComplete":this.onShakeComplete
         });
      }
      
      private function onShakeUpdate(param1:Tween) : void
      {
         this._image.x = SHAKE_DISTANCE * Math.sin(param1.target.fraction * SHAKE_FREQUENCY * Math.PI);
      }
      
      private function onShakeComplete() : void
      {
         this._image.x = 0;
         removeTween(this._shakeTween);
         this._shakeTween = null;
      }
      
      private function onInputHandler(param1:InputEvent) : void
      {
         if(!(visible && param1.details.value == KeyboardEvent.KEY_DOWN))
         {
            return;
         }
         var _loc2_:Number = param1.details.code;
         switch(_loc2_)
         {
            case Keyboard.BACKSPACE:
               removeCharS();
               break;
            case Keyboard.DELETE:
            case Keyboard.NUMPAD_DECIMAL:
               deleteAllS();
               break;
            case Keyboard.ENTER:
            case Keyboard.NUMPAD_ENTER:
               param1.stopImmediatePropagation();
               finishS();
               break;
            default:
               if(checkKeyCode(_loc2_))
               {
                  sendCharS(getNumberByCode(_loc2_).toString());
               }
         }
      }
   }
}
