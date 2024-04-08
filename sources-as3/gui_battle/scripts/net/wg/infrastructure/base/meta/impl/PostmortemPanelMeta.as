package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.views.postmortemPanel.BasePostmortemPanel;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PostmortemPanelMeta extends BasePostmortemPanel
   {
       
      
      public var onDogTagKillerInPlaySound:Function;
      
      public var onDogTagKillerOutPlaySound:Function;
      
      public var onVictimDogTagInPlaySound:Function;
      
      private var _dogTagVO:DogTagVO;
      
      private var _dogTagVO1:DogTagVO;
      
      private var _array:Array;
      
      public function PostmortemPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._dogTagVO)
         {
            this._dogTagVO.dispose();
            this._dogTagVO = null;
         }
         if(this._dogTagVO1)
         {
            this._dogTagVO1.dispose();
            this._dogTagVO1 = null;
         }
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         super.onDispose();
      }
      
      public function onDogTagKillerInPlaySoundS() : void
      {
         App.utils.asserter.assertNotNull(this.onDogTagKillerInPlaySound,"onDogTagKillerInPlaySound" + Errors.CANT_NULL);
         this.onDogTagKillerInPlaySound();
      }
      
      public function onDogTagKillerOutPlaySoundS() : void
      {
         App.utils.asserter.assertNotNull(this.onDogTagKillerOutPlaySound,"onDogTagKillerOutPlaySound" + Errors.CANT_NULL);
         this.onDogTagKillerOutPlaySound();
      }
      
      public function onVictimDogTagInPlaySoundS() : void
      {
         App.utils.asserter.assertNotNull(this.onVictimDogTagInPlaySound,"onVictimDogTagInPlaySound" + Errors.CANT_NULL);
         this.onVictimDogTagInPlaySound();
      }
      
      public final function as_showKillerDogTag(param1:Object, param2:Boolean) : void
      {
         var _loc3_:DogTagVO = this._dogTagVO;
         this._dogTagVO = new DogTagVO(param1);
         this.showKillerDogTag(this._dogTagVO,param2);
         if(_loc3_)
         {
            _loc3_.dispose();
         }
      }
      
      public final function as_showVictimDogTag(param1:Object) : void
      {
         var _loc2_:DogTagVO = this._dogTagVO1;
         this._dogTagVO1 = new DogTagVO(param1);
         this.showVictimDogTag(this._dogTagVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_preloadComponents(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.preloadComponents(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function showKillerDogTag(param1:DogTagVO, param2:Boolean) : void
      {
         var _loc3_:String = "as_showKillerDogTag" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function showVictimDogTag(param1:DogTagVO) : void
      {
         var _loc2_:String = "as_showVictimDogTag" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function preloadComponents(param1:Array) : void
      {
         var _loc2_:String = "as_preloadComponents" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
