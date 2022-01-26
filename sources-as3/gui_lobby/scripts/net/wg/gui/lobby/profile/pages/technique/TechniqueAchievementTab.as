package net.wg.gui.lobby.profile.pages.technique
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.lobby.profile.components.ResizableContent;
   import net.wg.gui.lobby.profile.pages.awards.AwardsMainContainer;
   import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
   
   public class TechniqueAchievementTab extends ResizableContent
   {
      
      private static const SB_MARGIN:Number = 10;
      
      private static const BLOCKS_GAP:Number = 6;
       
      
      public var scrollPane:ResizableScrollPane;
      
      public var warningTextField:TextField;
      
      public var listBg:MovieClip;
      
      private var _data:ProfileVehicleDossierVO;
      
      private var _scrollPaneVisible:Boolean = false;
      
      public function TechniqueAchievementTab()
      {
         super();
      }
      
      private static function isHasAchievements(param1:Array) : Boolean
      {
         var _loc2_:Array = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_.length > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function applyResizing() : void
      {
         super.applyResizing();
         this.scrollPane.setSize(currentDimension.x - this.scrollPane.x,currentDimension.y - this.scrollPane.y);
         this.listBg.height = currentDimension.y - this.listBg.y;
      }
      
      override public function update(param1:Object) : void
      {
         var _loc3_:Array = null;
         var _loc2_:ProfileVehicleDossierVO = ProfileVehicleDossierVO(param1);
         if(this._data != _loc2_)
         {
            this._data = _loc2_;
            _loc3_ = _loc2_.achievementsVOs;
            this.scrollPane.visible = false;
            if(_loc3_)
            {
               if(isHasAchievements(_loc3_))
               {
                  this.warningTextField.visible = false;
                  this._scrollPaneVisible = true;
               }
               else
               {
                  this.warningTextField.visible = true;
                  this._scrollPaneVisible = false;
                  this.scrollPane.visible = false;
               }
            }
            else
            {
               this.warningTextField.visible = true;
               this._scrollPaneVisible = false;
               this.scrollPane.visible = false;
            }
            this.getPaneContent().data = _loc3_;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.warningTextField.autoSize = TextFieldAutoSize.LEFT;
         this.warningTextField.text = PROFILE.SECTION_TECHNIQUE_AWARDS_NOACHIEVEMENTS;
         this.warningTextField.visible = false;
         this.scrollPane.visible = false;
         this.scrollPane.scrollBarMargin = SB_MARGIN;
         this.getPaneContent().gapBetweenBlocks = BLOCKS_GAP;
         this.scrollPane.target.addEventListener(Event.RESIZE,this.onScrollPaneResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         if(this.scrollPane)
         {
            this.scrollPane.target.removeEventListener(Event.RESIZE,this.onScrollPaneResizeHandler);
            this.scrollPane.dispose();
            this.scrollPane = null;
         }
         super.onDispose();
      }
      
      private function getPaneContent() : AwardsMainContainer
      {
         return AwardsMainContainer(this.scrollPane.target);
      }
      
      private function onScrollPaneResizeHandler(param1:Event) : void
      {
         this.scrollPane.visible = this._scrollPaneVisible;
      }
   }
}
