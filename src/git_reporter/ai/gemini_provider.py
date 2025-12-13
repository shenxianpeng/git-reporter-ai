"""Google Gemini provider implementation."""

from typing import Optional

from pydantic_ai import Agent
from pydantic_ai.models.gemini import GeminiModel

from ..models import GitCommit, ReportPeriod
from .base import AIProvider as BaseAIProvider


class GeminiProvider(BaseAIProvider):
    """Google Gemini-based AI provider using pydantic-ai."""

    def __init__(self, api_key: str, model: str = "gemini-2.0-flash-exp"):
        """Initialize the Gemini provider.

        Args:
            api_key: Google AI API key
            model: Model name to use
        """
        self.api_key = api_key
        self.model = model

    async def generate_report(
        self,
        commits: list[GitCommit],
        period: ReportPeriod,
        additional_context: Optional[str] = None,
    ) -> str:
        """Generate a report summary from commits using Gemini.

        Args:
            commits: List of commits to summarize
            period: Report period
            additional_context: Optional additional context

        Returns:
            Generated report text
        """
        if not commits:
            return "No commits found in this period."

        # Create pydantic-ai agent with Gemini model
        model = GeminiModel(self.model, api_key=self.api_key)
        agent = Agent(
            model=model,
            system_prompt=self._create_system_prompt(period),
        )

        # Format commits
        commits_text = self._format_commits_for_prompt(commits)

        # Create user prompt
        user_prompt = (
            f"Please create a {period.value} work report based on these commits:\n\n"
            f"{commits_text}\n\n"
        )

        if additional_context:
            user_prompt += f"Additional context: {additional_context}\n\n"

        user_prompt += (
            "Generate a professional summary suitable for sharing with a manager."
        )

        # Run the agent
        result = await agent.run(user_prompt)

        return result.data
