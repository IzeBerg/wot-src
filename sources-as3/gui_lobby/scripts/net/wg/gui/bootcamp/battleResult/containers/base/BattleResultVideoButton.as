package net.wg.gui.bootcamp.battleResult.containers.base
{
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.battleResult.data.RewardVideoDataVO;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.infrastructure.managers.IStageSizeManager;
   import net.wg.utils.IStageSizeDependComponent;
   import scaleform.clik.constants.InvalidationType;
   
   public class BattleResultVideoButton extends SoundButtonEx implements IUpdatable, IStageSizeDependComponent
   {
      
      private static const STAGE_SIZE:String = "stageSize";
       
      
      public var content:BattleResultVideoButtonContent = null;
      
      public var emptyFocusIndicator:MovieClip = null;
      
      private var _videoData:RewardVideoDataVO = null;
      
      private var _stageSizeMgr:IStageSizeManager;
      
      public function BattleResultVideoButton()
      {
         this._stageSizeMgr = App.stageSizeMgr;
         super();
         preventAutosizing = true;
         this._stageSizeMgr.register(this);
      }
      
      public function update(param1:Object) : void
      {
         this._videoData = RewardVideoDataVO(param1);
         invalidateData();
      }
      
      public function get videoData() : RewardVideoDataVO
      {
         return this._videoData;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         invalidate(STAGE_SIZE);
      }
      
      override public function get width() : Number
      {
         return super.actualWidth;
      }
      
      override public function get height() : Number
      {
         return super.actualHeight;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         focusIndicator = this.emptyFocusIndicator;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._videoData != null && isInvalid(InvalidationType.DATA))
         {
            this.validateData();
         }
         if(this._videoData != null && isInvalid(STAGE_SIZE,InvalidationType.DATA))
         {
            this.content.updateSize(this._videoData.totalCount);
         }
      }
      
      override protected function onDispose() : void
      {
         this.content.dispose();
         this.content = null;
         this.emptyFocusIndicator = null;
         this._videoData = null;
         this._stageSizeMgr.unregister(this);
         this._stageSizeMgr = null;
         super.onDispose();
      }
      
      private function validateData() : void
      {
         this.content.source = this._videoData.image;
      }
   }
}
