package net.wg.infrastructure.base.meta.impl
{
   import flash.display.DisplayObject;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   
   public class AbstractTweenMeta extends BaseDAAPIModule
   {
       
      
      public var initialiaze:Function;
      
      public var creatTweenPY:Function;
      
      public var getPaused:Function;
      
      public var setPaused:Function;
      
      public var getLoop:Function;
      
      public var setLoop:Function;
      
      public var getDuration:Function;
      
      public var setDuration:Function;
      
      public var getPosition:Function;
      
      public var setPosition:Function;
      
      public var getDelay:Function;
      
      public var setDelay:Function;
      
      public var resetAnim:Function;
      
      public var getTweenIdx:Function;
      
      public var getIsComplete:Function;
      
      public var postponedCheckState:Function;
      
      public function AbstractTweenMeta()
      {
         super();
      }
      
      public function initialiazeS(param1:ITweenPropertiesVO) : void
      {
         App.utils.asserter.assertNotNull(this.initialiaze,"initialiaze" + Errors.CANT_NULL);
         this.initialiaze(param1);
      }
      
      public function creatTweenPYS(param1:DisplayObject) : void
      {
         App.utils.asserter.assertNotNull(this.creatTweenPY,"creatTweenPY" + Errors.CANT_NULL);
         this.creatTweenPY(param1);
      }
      
      public function getPausedS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.getPaused,"getPaused" + Errors.CANT_NULL);
         return this.getPaused();
      }
      
      public function setPausedS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setPaused,"setPaused" + Errors.CANT_NULL);
         this.setPaused(param1);
      }
      
      public function getLoopS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.getLoop,"getLoop" + Errors.CANT_NULL);
         return this.getLoop();
      }
      
      public function setLoopS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setLoop,"setLoop" + Errors.CANT_NULL);
         this.setLoop(param1);
      }
      
      public function getDurationS() : uint
      {
         App.utils.asserter.assertNotNull(this.getDuration,"getDuration" + Errors.CANT_NULL);
         return this.getDuration();
      }
      
      public function setDurationS(param1:uint) : void
      {
         App.utils.asserter.assertNotNull(this.setDuration,"setDuration" + Errors.CANT_NULL);
         this.setDuration(param1);
      }
      
      public function getPositionS() : uint
      {
         App.utils.asserter.assertNotNull(this.getPosition,"getPosition" + Errors.CANT_NULL);
         return this.getPosition();
      }
      
      public function setPositionS(param1:uint) : void
      {
         App.utils.asserter.assertNotNull(this.setPosition,"setPosition" + Errors.CANT_NULL);
         this.setPosition(param1);
      }
      
      public function getDelayS() : uint
      {
         App.utils.asserter.assertNotNull(this.getDelay,"getDelay" + Errors.CANT_NULL);
         return this.getDelay();
      }
      
      public function setDelayS(param1:uint) : void
      {
         App.utils.asserter.assertNotNull(this.setDelay,"setDelay" + Errors.CANT_NULL);
         this.setDelay(param1);
      }
      
      public function resetAnimS() : void
      {
         App.utils.asserter.assertNotNull(this.resetAnim,"resetAnim" + Errors.CANT_NULL);
         this.resetAnim();
      }
      
      public function getTweenIdxS() : uint
      {
         App.utils.asserter.assertNotNull(this.getTweenIdx,"getTweenIdx" + Errors.CANT_NULL);
         return this.getTweenIdx();
      }
      
      public function getIsCompleteS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.getIsComplete,"getIsComplete" + Errors.CANT_NULL);
         return this.getIsComplete();
      }
      
      public function postponedCheckStateS() : void
      {
         App.utils.asserter.assertNotNull(this.postponedCheckState,"postponedCheckState" + Errors.CANT_NULL);
         this.postponedCheckState();
      }
   }
}
