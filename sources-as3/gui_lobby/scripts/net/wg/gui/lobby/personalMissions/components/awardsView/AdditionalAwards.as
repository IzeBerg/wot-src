package net.wg.gui.lobby.personalMissions.components.awardsView
{
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TEXT_ALIGN;
   import net.wg.gui.components.common.containers.TiledLayout;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.lobby.personalMissions.data.AdditionalAwardsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class AdditionalAwards extends UIComponentEx implements IUpdatable
   {
      
      private static const AWARDS_COUNT:int = 3;
      
      private static const AWARDS_GAP:int = 16;
      
      private static const AWARDS_RENDERER_WIDTH:int = 80;
      
      private static const AWARDS_RENDERER_HEIGHT:int = 80;
       
      
      public var text:TextField = null;
      
      public var group:GroupEx = null;
      
      private var _model:AdditionalAwardsVO = null;
      
      private var _awardsWidth:int = 0;
      
      public function AdditionalAwards()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:TiledLayout = new TiledLayout(AWARDS_RENDERER_WIDTH,AWARDS_RENDERER_HEIGHT,AWARDS_COUNT,TEXT_ALIGN.LEFT);
         this.group.layout = _loc1_;
         this.group.itemRendererLinkage = Linkages.AWARD_RENDERER;
         _loc1_.gap = AWARDS_GAP;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            this.text.htmlText = this._model.title;
            App.utils.commons.updateTextFieldSize(this.text,true,false);
            this.text.x = this._awardsWidth - this.text.width >> 1;
            if(this.group.dataProvider)
            {
               this.group.dataProvider.cleanUp();
            }
            this.group.dataProvider = this._model.awards;
         }
      }
      
      override protected function onDispose() : void
      {
         this.group.dispose();
         this.group = null;
         this.text = null;
         this._model = null;
         super.onDispose();
      }
      
      public function getAwardsWidth() : int
      {
         return this._awardsWidth;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(param1 != null && param1 != this._model)
         {
            this._model = AdditionalAwardsVO(param1);
            _loc2_ = this._model.awards.length;
            this._awardsWidth = (AWARDS_RENDERER_WIDTH + AWARDS_GAP) * _loc2_ - AWARDS_GAP;
            invalidateData();
         }
      }
   }
}
